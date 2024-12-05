<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>OTP Verification</title>
</head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<style>
		/* From Uiverse.io by vinodjangid07 */ 
.otp-Form {
  width: 530px;
  height: 300px;
  background-color: rgb(255, 255, 255);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px 30px;
  gap: 20px;
  position: relative;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.082);
  border-radius: 15px;
}

.mainHeading {
  font-size: 1.1em;
  color: rgb(15, 15, 15);
  font-weight: 700;
}

.otpSubheading {
  font-size: 0.7em;
  color: black;
  line-height: 17px;
  text-align: center;
}

.inputContainer {
  width: 100%;
  display: flex;
  flex-direction: row;
  gap: 10px;
  align-items: center;
  justify-content: center;
}

.otp-input {
  background-color: rgb(228, 228, 228);
  width: 30px;
  height: 30px;
  text-align: center;
  border: none;
  border-radius: 7px;
  caret-color: rgb(127, 129, 255);
  color: rgb(44, 44, 44);
  outline: none;
  font-weight: 600;
}

.otp-input:focus,
.otp-input:valid {
  background-color: rgba(127, 129, 255, 0.199);
  transition-duration: .3s;
}

.verifyButton {
  width: 100%;
  height: 30px;
  border: none;
  background-color: rgb(127, 129, 255);
  color: white;
  font-weight: 600;
  cursor: pointer;
  border-radius: 10px;
  transition-duration: .2s;
}

.verifyButton:hover {
  background-color: rgb(144, 145, 255);
  transition-duration: .2s;
}

.exitBtn {
  position: absolute;
  top: 5px;
  right: 5px;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.171);
  background-color: rgb(255, 255, 255);
  border-radius: 50%;
  width: 25px;
  height: 25px;
  border: none;
  color: black;
  font-size: 1.1em;
  cursor: pointer;
}

.resendNote {
  font-size: 0.7em;
  color: black;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 5px;
}

.resendBtn {
  background-color: transparent;
  border: none;
  color: rgb(127, 129, 255);
  cursor: pointer;
  font-size: 1.1em;
  font-weight: 700;
}
	</style>
<body>
	<div class="container">
		<div class="row">
			<div class="col-3" ></div>
			<div class="col-8" style=" margin-top: 100px;">
				<form action="verify-otp" method="post" class="otp-Form">
	 
				  <span class="mainHeading">Enter OTP</span>
				  <p class="otpSubheading">We have sent a verification code to your mobile number</p>
				  <div class="inputContainer">
				   <input type="text" id="otp" name="otp" required class="form-control" max="5">
				  </div>
				   <button class="verifyButton" type="submit">Verify</button>
				     <button class="exitBtn">×</button>
				     <p class="resendNote">Didn't receive the code? <button class="resendBtn">Resend Code</button></p>
				     
				</form>
			</div>
			<div class="col-1"></div>
		</div>
	</div>
	

	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>
</html>