<%
   id   = Request("id")
   pin   = Request("pin")


  set Com = server.createobject("TesterAPICall.TesterAPI")
  sessionCode= Com.Login_Click_1(id,pin)



   htmlView = "<div>seesion_id = "+sessionCode+"</div> "+"<div>usrid = "+id+"</div> "+"<div>pincode = "+pin+"</div>"
   Response.Write htmlView
%>