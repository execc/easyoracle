const SDK = require('@wiotp/sdk')
const express = require('express')

const { ApplicationClient, ApplicationConfig } = SDK

process.env.WIOTP_AUTH_TOKEN='_8k9sgYY&jFbCZ*nEY'
process.env.WIOTP_AUTH_KEY='a-eigw4f-qbhh1m7504'

const cache = {}

let appConfig = ApplicationConfig.parseEnvVars();
let appClient = new ApplicationClient(appConfig);

const cb = async (type, id, event, _, data) => {
    // Store sensor data in IPFS
    const dataId = new Date().getTime().toString()
    console.log(`Got measurement ${dataId}`)
    const dataAsString = data.toString('utf-8')
    const json = JSON.parse(dataAsString)
    console.log(`Updated cached value key=[${type}/${id}/${event}] value = ${JSON.stringify(json, null, 2)}`)
    cache[`${type}/${id}/${event}`] = json
}

appClient.connect();

setTimeout(() => {
    // Subscribe to events from all devices
    //
    appClient.addListener('deviceEvent', cb); 
    appClient.subscribeToEvents();
}, 2000)

// Init web service
const app = express()
const port = 3002

app.get('/devices/:type/:event/:id', (req, res) => {
    const type = req.params.type
    const event = req.params.event
    const id = req.params.id
    const result = cache[`${type}/${id}/${event}`]
    res.send(JSON.stringify(result))
})

app.listen(port, () => {
    console.log(`IBM Watson IoT Gateway is listening on http://localhost:${port}`)
})