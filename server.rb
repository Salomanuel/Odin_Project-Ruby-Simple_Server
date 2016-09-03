require 'socket'

server = TCPServer.open(2000)
loop {
	Thread.start(server.accept) do |client|
		request = client.read_nonblock(256) #without this it does not work
		
		request_header, request_body = request.split("\r\n\r\n", 2)
		
		request.split.each_with_index do |j,k|
			puts "on position #{k} we have #{j}"
		end

		path   = request_header.split[1][1..-1]

		response_body = File.read(path)
		client.puts "HTTP/1.1 200 OK\r\nContent-type:text/html\r\n\r\n"
		client.puts response_body
		client.close
	end
}