export function backgroundProcess(callback) {
  let process = window.childProcess.spawn('pwd')

  process.stdout.on('data', callback)

  process.stderr.on('data', data => console.log('stderr: ' + data))

  process.on('close', function(code) {
    if (code === 0) {
      console.log('child process complete.')
    } else {
      console.log('child process exited with code ' + code)
    }
  })
}
