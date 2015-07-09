<cfset request.jxKey = "1">
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<html>
<head>
	<title>Test CF AJAX Page</title>
	<style>
	body {
		font-family: Arial;
		font-size: 10px;	
	}
	.chatlogin {
		left : 20px;
		position : absolute;
		width:200px;
		height:200px;
		top:50px;
		border : solid;
		padding: 2px;
		border-width:1px;
	}
	.chatbox {
		left : 230px;
		position : absolute;
		width:350px;
		height:400px;
		overflow : scroll;
		top:100px;
		border : solid;
		padding: 2px;
		border-width:1px;
	}
	.chatusers {
		left : 590px;
		position : absolute;
		width:200px;
		height:400px;
		overflow : scroll;
		top:50px;
		border : solid;
		padding: 2px;
		border-width:1px;
	}
	.chatcomment {
		left : 230px;
		position : absolute;
		width:350px;
		height:20px;
		top:50px;
		border : solid;
		padding: 2px;
		border-width:1px;
	}
	</style>
</head>

<!--- The page is going to use AJAX --->
<cf_jx showStatusBar="true">

	<!--- An AJAX status bar --->
	<cf_jx_statusbar style="align:center;background-color:pink;border-width:1px;border-style:solid">Please Wait...</cf_jx_statusbar> 
	<body>
	<h3>Chat App Version 1</h3>
	<cf_jx_div id="logout" class="chatlogin">
		<cfif isDefined("session.loggedin") and session.loggedin neq false>
			<cf_jx_a id="logoutlink" targets="logout" urls="#request.link#/ajax/chatserver.cfm?fuseaction=logout">Logout #session.loggedin#</cf_jx_a> 
		<cfelse>
		<cf_jx_form id="login" name="f1" targets="logout" urls="#request.link#/ajax/chatserver.cfm?fuseaction=login">
			Name:<br />
			<input type="text" name="fullname" /><br /><br />
			Email:<br />
			<input type="text" name="email" /><br /><br />
			Password:<br />
			<input type="text" name="password" /><br /><br />
			<input type="submit" value="login" /><br /><br />
		</cf_jx_form>
		</cfif>
	</cf_jx_div>	
			
	<!--- refresh the chat and users every 1 second --->
	<cf_jx_request interval="1000" 
				   targets="conversation,users" 
	               urls="#request.link#/ajax/chatserver.cfm?fuseaction=chat,#request.link#/ajax/chatserver.cfm?fuseaction=users">
	<cf_jx_div id="conversation" class="chatbox">
	</cf_jx_div>
	<div class="chatcomment">
	<cf_jx_form id="login" name="f2" targets="conversation" urls="#request.link#/ajax/chatserver.cfm?fuseaction=add">
		<input name="message" type="text" size="30" maxlength="255" /><input type="submit" value="add comment" />
	</cf_jx_form>
	</div>
			
	<cf_jx_div id="users" class="chatusers">
	</cf_jx_div>
	<cf_jx_a id="reset" targets="logout" urls="#request.link#/ajax/chatserver.cfm?fuseaction=reset" style="position:absolute;top:400px">reset</cf_jx_a>
	</body>
</cf_jx>

</html>
</cfoutput>