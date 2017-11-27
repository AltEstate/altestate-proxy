import fastify from 'fastify'
import Web3 from 'web3'

const web3 = new Web3(new Web3.providers.HttpProvider(process.env.WEB3))

const server = fastify()

const opts = {
  schema: {
    body: {
      type: 'object',
      properties: {
        contract: { type: 'string' },
        at: { type: 'string' },
        method: { type: 'string' },
        args: { type: 'array' }
      }
    }
  }
}

server.post('/*', opts, async (request, reply) => {
  const commands = request.params['*'].split('/')
  let func = web3.eth

  for (let part of commands) {
    console.log('get part:', part)
    func = func[part]
  }

  console.log(func)

  func((error, result) => {
    if (error) {
      return reply.send(error)
    }

    return reply.send(result)
  })
}) 

// Run the server!
server.listen(3000, function (err) {
  if (err) throw err
  server.log.info(`server listening on ${server.server.address().port}`)
})