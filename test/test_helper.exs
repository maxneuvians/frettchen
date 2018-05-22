ExUnit.start(capture_log: true)
Code.load_file("test/test_udp_server.ex")
Frettchen.TestUdpServer.start_link()
