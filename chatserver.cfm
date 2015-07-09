<!--- All response --->
<cfif not isDefined("application.users")>
	<cfset application.users = structnew()>
</cfif>
<cfif not isDefined("application.chat")>
	<cfset application.chat = arrayNew(1)>
</cfif>

<!--- Ajax response --->
<cf_jx_response>
	<cfswitch expression="#attributes.fuseaction#">
	
		<!--- User logs in --->
		<cfcase value="login">
			<cfif isDefined("attributes.fullname") and (not isDefined("session.loggedin") or session.loggedin eq false)>
				<cfset temp = structinsert(application.users,attributes.fullname,structnew(),"yes")>
				<cfset application.users[attributes.fullname].email = attributes.email>
				<cfset session.loggedin = attributes.fullname>
			</cfif>
			<cfoutput>
			<p>#attributes.fullname# logged in at #timeformat(now(),"HH:MM")# #dateformat(now(),"dd/mm/yyyy")#<br /><br />
			<cf_jx_a id="logoutlink" targets="logout" urls="#request.link#/ajax/chatserver.cfm?fuseaction=logout">Logout</cf_jx_a> 
			</p>
			</cfoutput>
		</cfcase>
		
		<!--- User logs out --->
		<cfcase value="logout">
			<cfset x = structdelete(application.users,session.loggedin,"yes")>
			<cfset session.loggedin = false>
			<cfoutput>
			<cf_jx_form id="login" name="f1" targets="logout" urls="#request.link#/ajax/chatserver.cfm?fuseaction=login">
				
				Name:<br />
				<input type="text" name="fullname" /><br /><br />
				Email:<br />
				<input type="text" name="email" /><br /><br />
				Password:<br />
				<input type="text" name="password" /><br /><br />
				<input type="submit" value="login" /><br /><br />
			</cf_jx_form>
			</cfoutput>
		</cfcase>
		
		<!--- Reset chat app --->
		<cfcase value="reset">
			<cfset x = structdelete(application.users,session.loggedin,"yes")>
			<cfset x = structclear(application)>
			<cfset session.loggedin = false>
			<cfoutput>
			<cf_jx_form id="login" name="f1" targets="logout" urls="#request.link#/ajax/chatserver.cfm?fuseaction=login">
				
				Name:<br />
				<input type="text" name="fullname" /><br /><br />
				Email:<br />
				<input type="text" name="email" /><br /><br />
				Password:<br />
				<input type="text" name="password" /><br /><br />
				<input type="submit" value="login" /><br /><br />
			</cf_jx_form>
			</cfoutput>
		</cfcase>
		
		<!--- dialog --->
		<cfcase value="chat">
			<cfoutput>
			<table>
			<cfif arraylen(application.chat)>
			<cfloop from="#arraylen(application.chat)#" to="1" index="pp" step="-1">
				<tr>
					<td>#application.chat[pp]#</td>
				</tr>	
			</cfloop>
			</cfif>
			</table>
			</cfoutput>
		</cfcase>
		
		<!--- User list --->
		<cfcase value="users">
			<cfoutput>
			<table>
			<cfloop collection="#application.users#" item="pp">
				<tr>
					<td>#pp#<br />
						<a href="mailto:#application.users[pp].email#">#application.users[pp].email#</a><br />
					</td>
				</tr>	
			</cfloop>
			</table>
			</cfoutput>
		</cfcase>
		
		<!--- Add some dialog --->
		<cfcase value="add">
			<cfif isDefined("session.loggedin") and session.loggedin neq false>
				<cfset x = arrayAppend(application.chat,session.loggedin&":"&htmleditformat(attributes.message))>
			<cfelse>
				<script>
				alert('Please log in');
				</script>
			</cfif>
		</cfcase>
		
	</cfswitch>
</cf_jx_response>