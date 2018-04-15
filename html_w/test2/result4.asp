<%
   acc   = Request("acc")
   id  = Request("id")
   pin  = Request("pin")

  set Com = server.createobject("TesterAPICall.TesterAPI")
  result= Com.GetAccountBalance(acc, id, pin)



   htmlView = result
   Response.Write htmlView
%>