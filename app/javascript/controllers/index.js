// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Reference: https://turbo.hotwired.dev/reference/events
// Turbp.session.drive = false
// Turbo = { false }

// We shall interrupt the turbo-drive lifecyle events here
// turbo prefetch can be disabled by adding <meta name="turbo-prefetch" content="false"> to html head
// document.addEventListener('turbo:before-fetch-request', async (event) => {
//   // # this is a preload request, we don't need to show the loader yet
//   if (event.detail.fetchOptions.headers['X-Sec-Purpose'] === 'prefetch') return

//   event.preventDefault()
//   document.querySelector('#loader').classList.toggle('hidden')
//   setTimeout(()=>event.detail.resume(), 1000)
// })

// document.addEventListener('turbo:before-render', async (event) => {
//   event.preventDefault()
//   document.querySelector('#loader').classList.toggle('hidden')
//   event.detail.resume()
// })

