<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <link rel="stylesheet" href="login.css">
</head>
<body>
  <div class="wrapper">
    <div class="title-text">
      <div class="title login">Login Form</div>
      <div class="title signup">Signup Form</div>
    </div>
    <div class="form-container">
      <div class="slide-controls">
        <input type="radio" name="slide" id="login" checked>
        <input type="radio" name="slide" id="signup">
        <label for="login" class="slide login">Login</label>
        <label for="signup" class="slide signup">Signup</label>
        <div class="slider-tab"></div>
      </div>
      <div class="form-inner">
        <form action="LoginServlet" method="post" class="login-form">
          <div class="field">
            <input type="text" name="email" placeholder="Email Address" required>
          </div>
          <div class="field">
            <input type="password" name="password" placeholder="Password" required>
          </div>
          <div class="pass-link"><a href="#">Forgot password?</a></div>
          <div class="field btn">
            <div class="btn-layer"></div>
            <input type="submit" value="Login">
          </div>
          <div class="signup-link">Not a member? <a href="#">Signup now</a></div>
        </form>
        
        <form action="SignUpServlet" method="post" class="signup-form">
          <div class="field">
            <input type="email" name="email" placeholder="Email Address" required>
          </div>
          <div class="field">
            <input type="password" name="password" placeholder="Password" required>
          </div>
          <div class="field">
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
          </div>
          <div class="field btn">
            <div class="btn-layer"></div>
            <input type="submit" value="Signup">
          </div>
          <div class="signup-link">Already a member? <a href="login.html">Login now</a></div>
        </form>
      </div>
    </div>
  </div>
  <script>
    // References to DOM elements
    const loginText = document.querySelector(".title-text .login");
    const signupText = document.querySelector(".title-text .signup");
    const loginForm = document.querySelector(".login-form");
    const signupForm = document.querySelector(".signup-form");
    const loginBtn = document.querySelector("label.login");
    const signupBtn = document.querySelector("label.signup");
    const signupLink = document.querySelector("form .signup-link a");

    // Show signup form and adjust text position
    signupBtn.onclick = () => {
        loginForm.style.display = "none"; // Hide login form
        signupForm.style.display = "block"; // Show signup form
        loginText.classList.remove("active"); // Remove active class from login
        signupText.classList.add("active"); // Add active class to signup
        loginText.style.visibility = "hidden"; // Hide login title
        signupText.style.visibility = "visible"; // Show signup title
    };

    // Show login form and adjust text position
    loginBtn.onclick = () => {
        signupForm.style.display = "none"; // Hide signup form
        loginForm.style.display = "block"; // Show login form
        signupText.classList.remove("active"); // Remove active class from signup
        loginText.classList.add("active"); // Add active class to login
        signupText.style.visibility = "hidden"; // Hide signup title
        loginText.style.visibility = "visible"; // Show login title
    };

    // Click on signup link moves to signup form
    signupLink.onclick = (event) => {
        event.preventDefault(); // Prevent default link behavior
        signupBtn.click(); // Trigger the signup button logic
    };
  </script>

  <style>
    /* Add CSS to handle the active state */
    .title-text .login.active {
      margin-left: 0%;
    }

    .title-text .signup.active {
      margin-left: -50%;
    }

    /* Ensure that only one title is visible at a time */
    .title-text .login, .title-text .signup {
      transition: visibility 0.0s ease; /* Optional smooth transition */
    }
  </style>
</body>
</html>
