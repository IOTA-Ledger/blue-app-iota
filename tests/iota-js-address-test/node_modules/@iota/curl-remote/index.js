let fetch = {}
if (typeof window === 'undefined') {
    fetch = require('node-fetch')
} else {
    fetch = window.fetch
}
const monkeyPatchIOTA = (iotaInstance, endpoint, delay = 1000, apiKey) => {
    // Save Sandbox URL
    iotaInstance.sandboxUrl = endpoint
    // Save API Key
    iotaInstance.sandboxKey = apiKey
    // Save Delay
    iotaInstance.sandboxDelay = delay
    // Leave old call accessible
    iotaInstance.api.oldAttachToTangle = iotaInstance.api.attachToTangle
    // Override the attachToTangle call
    iotaInstance.api.attachToTangle = async (
        trunk,
        branch,
        mwm,
        trytes,
        callback
    ) => {
        // Validate all the things!
        validate(iotaInstance, trunk, branch, mwm, trytes, callback)

        // Send ATT call to the sandbox
        let jobId = await sandboxATT(
            trunk,
            branch,
            mwm,
            trytes,
            iotaInstance.sandboxUrl,
            iotaInstance.sandboxKey
        )
        let jobCompletionTaskId
        let jobCompletionChecker = async () => {
            let taskResult = await sandboxCheckResult(
                jobId,
                iotaInstance.sandboxUrl
            )
            if (taskResult.error) {
                // Check if there is an error
                callback(new Error(taskResult.errorMessage), null)
            } else if (taskResult.progress === '100') {
                // Check is the PoW is finished
                callback(null, taskResult.response.trytes)
            } else {
                // Else recheck after specified delay
                jobCompletionTaskId = setTimeout(
                    jobCompletionChecker,
                    iotaInstance.sandboxDelay
                )
            }
        }
        jobCompletionTaskId = setTimeout(
            jobCompletionChecker,
            iotaInstance.sandboxDelay
        )
    }
}
// Call the Sandbox
const sandboxATT = async (trunk, branch, mwm, trytes, sandbox, apiKey) => {
    // Create Request Payload
    const payload = {
        command: 'attachToTangle',
        trunkTransaction: trunk,
        branchTransaction: branch,
        minWeightMagnitude: mwm,
        trytes: trytes
    }
    // Create Request Object
    let params = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
    }
    // If API add auth
    if (apiKey) params.headers['Authorization'] = apiKey
    // Post job to Sandbox
    const response = await fetch(`${sandbox}/api/v1/commands`, params)
    const data = await response.json()
    return data.jobId
}
// Check the progress of the PoW
const sandboxCheckResult = async (jobId, sandbox) => {
    const response = await fetch(`${sandbox}/api/v1/jobs/${jobId}`, {
        method: 'GET'
    })
    const data = await response.json()
    return data
}

const validate = (iotaInstance, trunk, branch, mwm, trytes, callback) => {
    // inputValidator: Check if correct hash
    if (!iotaInstance.valid.isHash(trunk))
        return callback(
            new Error(
                'You have provided an invalid hash as a trunk/branch: ' + trunk
            ),
            null
        )

    // inputValidator: Check if correct hash
    if (!iotaInstance.valid.isHash(branch))
        return callback(
            new Error(
                'You have provided an invalid hash as a trunk/branch: ' + branch
            ),
            null
        )

    // inputValidator: Check if int
    if (!iotaInstance.valid.isValue(mwm)) {
        return callback(new Error('One of your inputs is not an integer'), null)
    }

    // inputValidator: Check if array of trytes
    if (!iotaInstance.valid.isArrayOfTrytes(trytes)) {
        return callback(new Error('Invalid Trytes provided'), null)
    }
}

module.exports = monkeyPatchIOTA
