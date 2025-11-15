<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Multi-Step Resident Form</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
@import url('https://fonts.googleapis.com/css?family=Montserrat');

* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Montserrat', sans-serif;
    background: linear-gradient(to right, #ff7e5f, #feb47b);
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

#msform {
    width: 400px;
    text-align: center;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

fieldset {
    display: none;
}

fieldset:first-of-type {
    display: block;
}

input {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

.action-button {
    width: 100px;
    background: #27ae60;
    color: white;
    border: 0;
    padding: 10px;
    margin: 10px;
    border-radius: 5px;
    cursor: pointer;
}

.action-button:hover {
    background: #219150;
}

#progressbar {
    display: flex;
    justify-content: space-between;
    list-style-type: none;
    padding: 0;
    margin-bottom: 30px;
}

#progressbar li {
    width: 30%;
    text-align: center;
    font-size: 12px;
    text-transform: uppercase;
    color: gray;
    position: relative;
}

#progressbar li.active {
    color: #27ae60;
    font-weight: bold;
}

#progressbar li:before {
    content: "";
    width: 15px;
    height: 15px;
    background: lightgray;
    display: block;
    margin: 0 auto 10px;
    border-radius: 50%;
}

#progressbar li.active:before {
    background: #27ae60;
}

</style>
<body>

<% Integer id = (Integer) session.getAttribute("residentId"); %>

<!-- Multi-Step Form -->
<form id="msform" action="ResidentProfileServlet" method="post">
    <ul id="progressbar">
        <li class="active">Profile</li>
        <li>Resident Info</li>
        <li>Staff Info</li>
    </ul>

    <!-- Step 1 -->
    <fieldset>
        <h2 class="fs-title">Edit Profile</h2>
        <h3 class="fs-subtitle">Provide your basic details</h3>
        <input type="hidden" name="resident-id" value="<%=(id != null) ? id : ""%>">
        <input type="text" name="first-name" placeholder="First Name" required />
        <input type="text" name="last-name" placeholder="Last Name" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="text" name="phone" placeholder="Phone Number" />
        <input type="text" name="alt-phone" placeholder="Alternative Number" />
        <button type="button" class="next action-button">Next</button>
    </fieldset>

    <!-- Step 2 -->
    <fieldset>
        <h2 class="fs-title">Resident Info</h2>
        <h3 class="fs-subtitle">Enter details about your residence</h3>
        <input type="text" name="flat-no" placeholder="Flat No" required />
        <input type="text" name="block-no" placeholder="Block Number" required />
        <button type="button" class="previous action-button">Back</button>
        <button type="button" class="next action-button">Next</button>
    </fieldset>

    <!-- Step 3 -->
    <fieldset>
        <h2 class="fs-title">Staff Info</h2>
        <h3 class="fs-subtitle">Details about your assigned staff</h3>
        <input type="text" name="staff-name" placeholder="Staff Name" required />
        <input type="text" name="staff-number" placeholder="Staff Number" required />
        <input type="text" name="staff-role" placeholder="Staff Role" required />
        <button type="button" class="previous action-button">Back</button>
        <button type="submit" class="action-button">Submit</button>
    </fieldset>
</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

<script>
$(document).ready(function() {
    var current_fs, next_fs, previous_fs;
    var animating;

    $(".next").click(function() {
        if (animating) return false;
        animating = true;

        current_fs = $(this).parent();
        next_fs = $(this).parent().next();

        // Highlight progress bar
        $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

        // Show next fieldset and hide the current one
        next_fs.show();
        current_fs.hide();
        animating = false;
    });

    $(".previous").click(function() {
        if (animating) return false;
        animating = true;

        current_fs = $(this).parent();
        previous_fs = $(this).parent().prev();

        // Remove active class from current step in progress bar
        $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

        // Show previous fieldset and hide the current one
        previous_fs.show();
        current_fs.hide();
        animating = false;
    });
});
</script>


</body>
</html>
