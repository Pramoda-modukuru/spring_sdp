<%@ include file="collegenavbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Portal Request</title>
    <style>
        /* CSS Styles */
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #141414;
            color: #fff;
            background-image: url('https://unsplash.com/photos/a-blue-and-purple-background-with-swirls-C4iq8xKzY3Q'); /* Background Image */
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Navbar Style */
        header {
            background: linear-gradient(135deg, #ff6f61, #af69ef);
            text-align: center;
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        header h1 {
            font-size: 3em;
            color: #fff;
            margin: 0;
        }

        main {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .form-container {
            background-color: rgba(31, 31, 46, 0.8);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 600px;
        }

        .form-container label {
            font-size: 1.2em;
            margin: 10px 0;
        }

        .form-container input[type="text"], .form-container textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #333;
            color: #fff;
            font-size: 1em;
        }

        .form-container button {
            padding: 12px 30px;
            font-size: 1.2em;
            background-color: #ff6f61;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-container button:hover {
            background-color: #af69ef;
        }
    </style>
</head>
<body>

    <main>
        <div class="form-container">
            <form action="processPortalRequest.jsp" method="post">
                <label for="requestTitle">Request Title:</label>
                <input type="text" name="requestTitle" required placeholder="Enter the request title">

                <label for="description">Description:</label>
                <textarea name="description" rows="4" required placeholder="Enter the request description"></textarea>

                <button type="submit">Submit Request</button>
            </form>
        </div>
    </main>
</body>
</html>
