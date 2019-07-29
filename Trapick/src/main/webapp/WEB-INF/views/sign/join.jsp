<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<style type="text/css">
body {
	display: table-cell;
	vertical-align: middle;
	background-color: #e0f2f1 !important;
}

html {
	display: table;
	margin: auto;
}

html, body {
	height: 100%;
}

.medium-small {
	font-size: 0.9rem;
	margin: 0;
	padding: 0;
}

.login-form {
	width: 280px;
}

.login-form-text {
	text-transform: uppercase;
	letter-spacing: 2px;
	font-size: 0.8rem;
}

.login-text {
	margin-top: -6px;
	margin-left: -6px !important;
}

.margin {
	margin: 0 !important;
}

.pointer-events {
	pointer-events: auto !important;
}

.input-field>.material-icons {
	padding-top: 10px;
}

.input-field div.error {
	position: relative;
	top: -1rem;
	left: 3rem;
	font-size: 0.8rem;
	color: #FF4081;
	-webkit-transform: translateY(0%);
	-ms-transform: translateY(0%);
	-o-transform: translateY(0%);
	transform: translateY(0%);
}
</style>
<script type="text/javascript">
$(function() {
	$(".join-form").validate({
		rules : {
			username : {
				required : true,
				minlength : 4
			},
			password : {
				required : true,
				minlength : 5
			}
		},
		//For custom messages
		messages : {
			username : {
				required : "Enter a username",
				minlength : "Enter at least 4 characters"
			}
		},
		errorElement : 'div',
		errorPlacement : function(error, element) {
			var placement = $(element).data('error');
			if (placement) {
				$(placement).append(error)
			} else {
				error.insertAfter(element);
			}
		}
		 ,
		submitHandler : function(form) {
			// do other things for a valid form
			form.submit();
		} 
	});
	
	

		
});

	
</script>
</head>
<body>
	<div id="join-page" class="row">
		<div class="col s12 z-depth-4 card-panel">
			<form  action = "/sign/joinPost" class="join-form" method = "post">
				<div class="row">
					<div class="input-field col s12 center">
						<h4>Register</h4>
						<p class="center">Join to our community now !</p>
					</div>
				</div>

				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-social-person-outline prefix"></i> -->
						<i class="material-icons prefix">account_circle</i> <input
							id="username" name="id" type="text" /> <label
							for="username">Username</label>
					</div>
				</div>

				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-social-person-outline prefix"></i> -->
						<i class="material-icons prefix">email</i> <input id="email"
							name="email" type="text" style="cursor: auto;" /> <label
							for="email">Email</label>
					</div>
				</div>

				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-action-lock-outline prefix"></i> -->
						<i class="material-icons prefix">vpn_key</i> <input id="password"
							name="pw" type="password" /> <label for="password">Password</label>
					</div>
				</div>

				<div class="row margin">
					<div class="input-field col s12">
						<!-- <i class="mdi-action-lock-outline prefix"></i> -->
						<i class="material-icons prefix">vpn_key</i> <input
							id="password_a" name="cpassword" type="password" /> <label
							for="password_a">Password again</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s12">
						<button type="submit" class="btn waves-effect waves-light col s12">REGISTERNOW</button>

					</div>
					<div class="input-field col s12">
						<p class="margin center medium-small sign-up">
							Already have an account? <a href="./login">Login</a>
						</p>
					</div>
				</div>


			</form>
		</div>
	</div>
</body>
</html>