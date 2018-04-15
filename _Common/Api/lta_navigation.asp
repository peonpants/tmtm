<%
		Sub Navigation(cType, Direc, TotalCnt, ViewCnt, Pram)
			Dim PageCount, tmpInteger, tmpString, BlockInt, cPage, pCnt
			Dim p1,p2,n1,n2

			cPage = Request("page") : pCnt = 1
			if cPage = "" then cPage = 1
			if TotalCnt < 1 then TotalCnt = 1
			if ViewCnt < 1 then Viewcnt = 10
			tmpInteger = TotalCnt mod ViewCnt : PageCount = fix(TotalCnt / ViewCnt)
			if tmpInteger > 0 then PageCount = PageCount + 1
			BlockInt = Int((cPage - 1) / 10) * 10 + 1
			
			If cType = 1 Then
				p1 = "<img src=""/images/common/btn_first.gif"" align=""absmiddle"">" : p2 = "<img src=""/images/common/btn_prev.gif"" align=""absmiddle"" style=""margin-right:5px;"">" : n1 = "<img src=""/images/common/btn_last.gif"" align=""absmiddle"" style=""margin-left:5px;"">" : n2 = "<img src=""/images/common/btn_next.gif"" align=""absmiddle"">"
			ElseIf cType = 2 Then 
				p1 = "<img src=""/images/pPrev.gif"" align=""absmiddle"">" : p2 = "<img src=""/images/Prev.gif"" align=""absmiddle"" style=""margin-right:5px;"">" : n1 = "<img src=""/images/pNext.gif"" align=""absmiddle"" style=""margin-left:5px;"">" : n2 = "<img src=""/images/Next.gif"" align=""absmiddle"">"
			ElseIf cType = 3 Then 
				p1 = "<img src=""/images/common/btn_01.gif"" align=""absmiddle"">" : p2 = "<img src=""/images/common/btn_02.gif"" align=""absmiddle"" style=""margin-right:5px;"">" : n1 = "<img src=""/images/common/btn_04.gif"" align=""absmiddle"" style=""margin-left:5px;"">" : n2 = "<img src=""/images/common/btn_03.gif"" align=""absmiddle"">"
			ElseIf cType = 4 Then 
				p1 = "<img src=""/images/pPrev.gif"" border=""0"" align=""absmiddle"">" : p2 = "<img src=""/images/prev.gif"" border=""0"" align=""absmiddle"">" : n1 = "<img src=""/images/pNext.gif"" border=""0"" align=""absmiddle"">" : n2 = "<img src=""/images/next.gif"" border=""0"" align=""absmiddle"">"
			ElseIf cType = 5 Then 
				p1 = "<img src=""/images/pPrev.gif"" border=""0"" align=""absmiddle"">" : p2 = "<img src=""/images/prev.gif"" border=""0"" align=""absmiddle"">" : n1 = "<img src=""/images/pNext.gif"" border=""0"" align=""absmiddle"">" : n2 = "<img src=""/images/next.gif"" border=""0"" align=""absmiddle"">"
			End If 

			if cPage > 1 Then
				If cType > 3 Then 
					Response.Write "<a href="""& Direc &"?page=1"& Pram &""">"& p1 &"</a>"
				Else 
					Response.Write "<a href="""& Direc &"?page=1"& Pram &""">"& p1 &"</a> "
				End If 
			Else
				If cType > 3 Then 
					Response.Write p1
				Else 
					Response.Write " "& p1 &" "
				End If 
			end If
			
			if BlockInt = 1 then
				Response.Write p2 & " &nbsp;"
			else
				Response.Write "<a href="""& Direc &"?page="& BlockInt - 1 & Pram &""">"& p2 &"</a> "
			end if
			do until pCnt > 10 or BlockInt > PageCount
				If pCnt > 1 Then
					If cType = 4 Then 
						Response.Write "<img src=""/images/dot_Paging.gif"" width=""12"" height=""3"" align=""absmiddle"">"
					ElseIf cType = 5 Then 
						Response.Write " <img src=""/images/common/pgn_bar.gif"" hspace=""3""> "
					Else 
						Response.Write " <img src=""/images/common/pgn_bar.gif"" hspace=""3""> "
					End If 
				End If 
				if Cint(BlockInt) = Cint(cPage) then
					Response.Write "<font color=""#FF0000""><b>" & BlockInt & "</b></font> "
				Else
					If cType = 4 Then 
						Response.Write "<a href="""& Direc &"?page="& BlockInt & Pram &""" class=""paging"">"& BlockInt &"</a> "
					ElseIf cType = 5 Then 
						Response.Write "<a href="""& Direc &"?page="& BlockInt & Pram &""">"& BlockInt &"</a> "
					Else 
						Response.Write "<a href="""& Direc &"?page="& BlockInt & Pram &""">"& BlockInt &"</a> "
					End If 
				end if
				pCnt = pCnt + 1 : BlockInt = BlockInt + 1								
			loop
			if BlockInt = PageCount+1 then
				Response.Write "&nbsp; "& n2
			Else
				If cType > 3 Then 
					Response.Write "&nbsp;<a href="""& Direc &"?page="& BlockInt & Pram &""">"& n2 &"</a>"
				Else
					Response.Write "&nbsp; <a href="""& Direc &"?page="& BlockInt & Pram &""">"& n2 &"</a>"
				End If 
			end if
			if Cint(cPage) = Cint(PageCount) Then
				If cType > 3 Then 
					Response.Write ""& n1
				Else
					Response.Write " "& n1 &" "
				End If 
			Else
				If cType > 3 Then 
					Response.Write "<a href="""& Direc &"?page="& PageCount & Pram &""">"& n1 &"</a>"
				Else
					Response.Write " <a href="""& Direc &"?page="& PageCount & Pram &""">"& n1 &"</a> "
				End If 
			end If
		End Sub
%>