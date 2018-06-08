const {app, BrowserWindow} = require('electron')
const path = require('path')
const url = require('url')

function createWindow () {
  mainWindow = new BrowserWindow({width: 800, height: 600})
  mainWindow.loadURL('http://localhost:8080')
  mainWindow.webContents.openDevTools()
}

app.on('ready', createWindow)
