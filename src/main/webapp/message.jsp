<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
@import url('https://fonts.googleapis.com/css?family=Montserrat');

body {
  font-family: 'Montserrat', sans-serif;
  width: 100%;
  font-size: 16px;
  margin: 0;
  padding: 0;
  background: linear-gradient(to right, #ff7e5f, #feb47b);
  height: 100vh; /* Ensures full-page coverage */
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Optional: Add a semi-transparent overlay for better readability */
.overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.1); /* Light overlay */
  z-index: -1;
}


h1, h2 {
  font-weight: 700;
  color: #FFF;
  font-size: 4em;
  margin: 0;
  padding: 0px 20px;
}

.form-overlay {
  width: 0%;
  height: 100%;
  top: 0; 
  left: 0;
  position: fixed;
  opacity: 0;
  background: #000;
  transition: background 1s, opacity 0.4s, width 0s 0.4s;
}

.show-form-overlay .form-overlay {
  width: 100%;
  opacity: 0.7;
  z-index: 999;
  transition: background 1s, opacity 0.4s, width 0s;
}

.show-form-overlay.form-submitted .form-overlay {
  background: #119DA4;
  transition: background 0.6s;
}

#form-container {
  cursor: pointer;
  color: #FFF;
  z-index: 1000;
  position: absolute;
  margin: 0 auto;
  left: 0;
  right: 0;
  bottom: 5vh;  
  background-color: #f72f4e;
  overflow: hidden;
  border-radius: 50%;
  width: 60px;
  max-width: 60px;
  height: 60px;
  text-align: center;
  box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
  transition: all 0.2s 0.45s, height 0.2s cubic-bezier(0.4, 0, 0.2, 1) 0.25s, max-width 0.2s cubic-bezier(0.4, 0, 0.2, 1) 0.35s, width 0.2s cubic-bezier(0.4, 0, 0.2, 1) 0.35s;
}

#form-container.expand {
  cursor: auto;
  box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.17);
  border-radius: 0;
  width: 70%;
  height: 610px;
  max-width: 610px;
  transition: all 0.2s, max-width 0.2s cubic-bezier(0.4, 0, 0.2, 1) 0.1s, height 0.3s ease 0.25s;
}

#form-close {
  cursor: pointer;
}

.icon::before {
  cursor: pointer;
  font-size: 30px;
  line-height: 60px;
  display: block;
  transition: all 0.7s cubic-bezier(0.4, 0, 0.2, 1);
}

.icon:hover::before {
  animation: wiggle 0.1s linear infinite;
}

.fa-pencil::before {
  display: block;
}

.fa-close::before {
  display: none;
}

.expand .fa-pencil::before {
  display: none;
}

.expand .fa-close::before {
  display: block;
}

#form-content {
  transform: translateY(150%);
  width: 100%;
  opacity: 0;
  text-align: left;
  transition: transform 0.2s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.2s 0.2s;
}

.expand #form-content {
  transform: translateY(0px);
  opacity: 1;
  transition: transform 0.7s cubic-bezier(0.4, 0, 0.2, 1) 0.3s, opacity 0s;
}

form {
  color: #FFF;
  width: 100%;
  padding: 0 20px 20px 20px;
  margin-bottom: 10px;
  box-sizing: border-box;
}

.input {
  background: rgba(0,0,0,0.2);
  display: block;
  height: 50px;
  width: 100%;
  margin: 10px 0;
  border: none;
  outline: none;
}

.input.submit {
  background-color: #FFF;
  color: #f72f4e;
  font-size: 120%;
  height: 80px;
  box-shadow: 0 5px rgba(0,0,0,0.5);
  transition: all 0.1s;
}

@keyframes wiggle {
  0%, 100% { transform: rotate(-15deg); }
  50% { transform: rotate(15deg); }
}
.help-heading {
  font-size: 32px;
  font-weight: bold;
  text-align: center;
  color: white; /* Ensures text stands out on dark backgrounds */
  text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5); /* Soft shadow for better readability */
  padding: 20px;
  background: linear-gradient(90deg, #32CD32, #008000); /* Green gradient */
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent; /* Creates a gradient text effect */
  animation: fadeIn 1s ease-in-out;
}

/* Optional animation for a smooth fade-in effect */
@keyframes fadeIn {
  0% { opacity: 0; transform: translateY(-10px); }
  100% { opacity: 1; transform: translateY(0); }
}


</style>
<body>

<h1 class="help-heading">Hello, Need Help? <br>Don't worry, we are always ready</h1>

    <div class="form-overlay"></div>
    <div id="form-container" class="icon">
        <span id="form-close" class="icon">&times;</span>
        <div id="form-content">
            <h1 class="post">Thanks!<br> we'll be in touch ASAP</h1>

            <!-- Contact Form -->
            <form action="MessageServlet" method="post">
                <input class="input name" type="text" name="user_name" placeholder="Your name please" required>
                <input class="input email" type="email" name="user_email" placeholder="A contact email" required>

                <select class="input select" name="subject" required>
                    <option disabled selected>What shall we talk about?</option>
                    <option>Facility & Maintenance Issues</option>
                    <option>Payment & Administration</option>
                    <option>Complaints & Suggestions</option>
                </select>

                <textarea class="input message" name="message" placeholder="How can I help?" required></textarea>
                <input class="input submit" type="submit" value="Send Message">
            </form>
        </div>
    </div>

</body>
</html>

<script>
document.addEventListener("DOMContentLoaded", function () {
    var formContainer = document.getElementById("form-container");
    var formClose = document.getElementById("form-close");
    var formOverlay = document.querySelector(".form-overlay");
    var form = document.querySelector("form");
    var formHead = document.getElementById("form-head"); // Ensure this exists

    // Open form only if clicking on the container, not inside the form
    formContainer.addEventListener("click", function (e) {
        if (!e.target.closest("form")) {
            toggleForm();
        }
    });

    // Close form when clicking the close button
    formClose.addEventListener("click", function (e) {
        e.preventDefault();
        toggleForm();
    });

    // Close form when clicking the overlay
    formOverlay.addEventListener("click", function (e) {
        e.preventDefault();
        toggleForm();
    });

    function toggleForm() {
        formContainer.classList.toggle("expand");
        document.body.classList.toggle("show-form-overlay");
        document.querySelector("#form-content").classList.toggle("expand");
    }

    // Form validation
    form.addEventListener("submit", function (e) {
        var inputs = document.querySelectorAll(".input");
        var formError = false;

        inputs.forEach(function (input) {
            if (input.value.trim() === "") {
                input.classList.add("form-error");
                formError = true;
            } else {
                input.classList.remove("form-error");
            }
        });

        // Validate email format
        var emailInput = document.querySelector(".email");
        if (!isValidEmail(emailInput.value)) {
            emailInput.classList.add("form-error");
            formError = true;
        }

        if (formError) {
            e.preventDefault(); // Prevent submission if there's an error
        } else {
            document.body.classList.add("form-submitted");
            if (formHead) formHead.classList.add("form-submitted"); // Ensure element exists

            setTimeout(function () {
                form.submit(); // ✅ Submit the form after validation
            }, 1000);
        }
    });

    function isValidEmail(email) {
        var pattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return pattern.test(email);
    }
});


</script>
</body>
</html>