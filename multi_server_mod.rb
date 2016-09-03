require 'socket'
server = TCPServer.open(2000)
loop {
	Thread.start(server.accept) do |client|
		request = client.read_nonblock(256)

		request_header, request_body = request.split("\r\n\r\n", 2)
		path   = request_header.split[1][1..-1]
		method = request_header.split[0]

		client.puts(Time.now.ctime)
		client.puts "Closing the connection. Bye!"
		client.close
	end
}