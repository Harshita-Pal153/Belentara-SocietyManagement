<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Notice Board</title>
    <style>
        /* Root Variables */
        :root {
            --bg-main: #1e1e2e;  /* Slightly lighter than pure black */
            --board-bg: #2c2c3e;
            --text-color: #e5e5e5;
            --shadow: rgba(0, 0, 0, 0.4);
            --note-yellow: #ffef94;
            --note-green: #b3f2a7;
            --note-blue: #a0c4ff;
            --note-pink: #f7a9bc;
            --note-purple: #d0a9f7;
            --bg-glass: rgba(40, 40, 60, 0.9);
        }

        /* Global Styling */
        body {
            font-family: "Arial", sans-serif;
            background: var(--bg-main);
            color: var(--text-color);
            margin: 0;
            padding: 20px;
            text-align: center;
            background-image: url('image.png'); /* Faded background */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            filter: brightness(95%);
        }

        /* Notice Board Section */
        .content-section {
            width: 90%;
            max-width: 1100px;
            margin: 0 auto;
            background: var(--bg-glass);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px var(--shadow);
            backdrop-filter: blur(8px);
            overflow: hidden;
        }

        .section-header h2 {
            color: var(--text-color);
            margin-bottom: 10px;
            font-size: 24px;
        }

        .board {
            width: 100%;
            min-height: 500px;
            background: var(--board-bg);
            border-radius: 12px;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: flex-start;
            gap: 20px;
            overflow: hidden;
            box-shadow: inset 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .board-container {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }

        /* Sticky Notes */
        .note {
            width: 220px;
            min-height: 150px;
            padding: 15px;
            border-radius: 8px;
            font-size: 14px;
            box-shadow: 2px 2px 8px var(--shadow);
            text-align: left;
            position: relative;
            transform: rotate(-1.5deg);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        /* Sticky Note Colors */
        .note:nth-child(1) { background: var(--note-yellow); }
        .note:nth-child(2) { background: var(--note-green); }
        .note:nth-child(3) { background: var(--note-blue); }
        .note:nth-child(4) { background: var(--note-pink); }
        .note:nth-child(5) { background: var(--note-purple); }
        .note:nth-child(n+6) { background: var(--note-yellow); }

        .note:hover {
            transform: rotate(0deg);
            box-shadow: 5px 5px 12px rgba(255, 255, 255, 0.2);
        }

        .note .title {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 5px;
            color: #222;
        }

        .note p {
            color: #333;
            font-size: 14px;
        }

        /* Sticky Tape Effect */
        .note::before {
            content: "";
            width: 50px;
            height: 15px;
            background: rgba(255, 255, 255, 0.7);
            position: absolute;
            top: -7px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 3px;
            box-shadow: 0px 2px 4px var(--shadow);
        }

        /* Animation */
        .note {
            opacity: 0;
            transform: translateY(10px);
            animation: fadeIn 0.5s ease-in-out forwards;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <div id="client-notice-board" class="content-section">
        <div class="section-header">
            <h2>📌 NOTICE BOARD</h2>
            <p>Stay updated with the latest notices.</p>
            <div class="board">
                <div class="board-container"></div> <!-- Notices will be added here -->
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            loadClientNotices();
        });

        function loadClientNotices() {
            fetch("NoticeServlet")
                .then(response => response.json())
                .then(data => {
                    let noticeBoard = document.querySelector("#client-notice-board .board-container");
                    if (!noticeBoard) {
                        console.error("Error: .board-container not found for client notice board.");
                        return;
                    }
                    noticeBoard.innerHTML = ""; // Clear existing notices

                    if (data.length === 0) {
                        noticeBoard.innerHTML = "<p>No notices available.</p>";
                        return;
                    }

                    // Loop through notices and display them as sticky notes
                    data.forEach(notice => {
                        let noticeDiv = document.createElement("div");
                        noticeDiv.classList.add("note");
                        noticeDiv.innerHTML = `
                            <h4 class="title">${notice.title}</h4>
                            <p>${notice.content}</p>
                        `;
                        noticeBoard.appendChild(noticeDiv);
                    });
                })
                .catch(error => console.error("Error loading notices:", error));
        }
    </script>

</body>
</html>
