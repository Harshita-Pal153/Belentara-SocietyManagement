class ThemeManager {
	static THEMES = {
		DARK: 'dark-theme',
		LIGHT: 'light-theme'
	};

	static currentTheme = localStorage.getItem('theme') || ThemeManager.THEMES.DARK;

	static toggleTheme() {
		const html = document.documentElement;
		if (this.currentTheme === this.THEMES.DARK) {
			html.classList.replace(this.THEMES.DARK, this.THEMES.Dark);
			this.currentTheme = this.THEMES.LIGHT;
		} else {
			html.classList.replace(this.THEMES.LIGHT, this.THEMES.Light);
			this.currentTheme = this.THEMES.DARK;
		}
		// Save the selected theme in localStorage
		localStorage.setItem('theme', this.currentTheme);
		return this.currentTheme;
	}
}

class NavigationSystem {
	static init() {
		const navLinks = document.querySelectorAll('.nav-links li');
		navLinks.forEach(link => {
			link.addEventListener('click', () => {
				this.switchSection(link.dataset.section, link.dataset.content);
				navLinks.forEach(l => l.classList.remove('active'));
				link.classList.add('active');
			});
		});
	}

	static switchSection(section, contentId) {
		document.querySelectorAll('.content-section').forEach(content => {
			content.classList.remove('active');
		});
		document.getElementById(contentId).classList.add('active');
	}
}

class ChartManager {
	static revenueChartOptions = {
		series: [{
			name: 'Revenue',
			data: [31000, 40000, 28000, 51000, 42000, 109000, 100000]
		}],
		chart: {
			type: 'area',
			height: 300,
			background: 'transparent',
			toolbar: { show: false },
			zoom: { enabled: false }
		},
		colors: ['#6d5acd'],
		fill: {
			type: 'gradient',
			gradient: {
				shadeIntensity: 1,
				opacityFrom: 0.7,
				opacityTo: 0.2,
				stops: [0, 90, 100]
			}
		},
		dataLabels: { enabled: false },
		stroke: {
			curve: 'smooth',
			width: 2
		},
		grid: {
			borderColor: '#1a1d25',
			strokeDashArray: 5
		},
		xaxis: {
			categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'jul'],
			labels: {
				style: { colors: '#a0a3bd' }
			}
		},
		yaxis: {
			labels: {
				style: { colors: '#a0a3bd' },
				formatter: (value) => `$${value.toLocaleString()}`
			}
		},
		tooltip: { theme: 'dark' }
	};

	static userActivityChartOptions = {
		series: [{
			name: 'Unsolved',
			data: [1, 4, 1, 0, 4, 2, 1]
		}, {
			name: 'Solved',
			data: [6, 5, 3, 5, 0, 5, 4]
		}],
		chart: {
			type: 'bar',
			height: 300,
			background: 'transparent',
			toolbar: { show: false },
			stacked: true
		},
		colors: ['#4361ee', '#6d5acd'],
		plotOptions: {
			bar: {
				horizontal: false,
				borderRadius: 5,
				columnWidth: '70%'
			}
		},
		dataLabels: { enabled: false },
		grid: {
			borderColor: '#1a1d25',
			strokeDashArray: 5
		},
		xaxis: {
			categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'jul'],
			labels: {
				style: { colors: '#a0a3bd' }
			}
		},
		yaxis: {
			labels: {
				style: { colors: '#a0a3bd' }
			}
		},
		tooltip: { theme: 'dark' }
	};

	static init() {
		const charts = [
			{
				element: "#revenueChart",
				options: this.revenueChartOptions
			},
			{
				element: "#userActivityChart",
				options: this.userActivityChartOptions
			},
		];

		charts.forEach(chart => {
			const element = document.querySelector(chart.element);
			if (element) {
				new ApexCharts(element, chart.options).render();
			}
		});
	}
}

class ActivityManager {
	static activities = [
		{
			user: "John Doe",
			action: "uploaded a file",
			time: "2 hours ago",
			icon: "upload",
			color: "#4caf50"
		},
		{
			user: "Jane Smith",
			action: "updated profile settings",
			time: "1 day ago",
			icon: "cog",
			color: "#2196f3"
		}
	];

	static init() {
		const activityList = document.getElementById('activityList');
		if (activityList) {
			this.activities.forEach(activity => {
				const activityItem = document.createElement('div');
				activityItem.className = 'activity-item';
				activityItem.innerHTML = `
                    <div class="activity-icon" style="background: ${activity.color}20; color: ${activity.color}">
                        <i class="fas fa-${activity.icon}"></i>
                    </div>
                    <div class="activity-content">
                        <p><strong>${activity.user}</strong> ${activity.action}</p>
                        <span>${activity.time}</span>
                    </div>
                `;
				activityList.appendChild(activityItem);
			});
		}
	}
}

class CounterAnimation {
	static init() {
		const counters = document.querySelectorAll('.counter');
		counters.forEach(counter => {
			const target = parseInt(counter.getAttribute('data-target')) || 0;
			const prefix = counter.hasAttribute('data-prefix') ? counter.getAttribute('data-prefix') : '';
			const duration = 2000;
			const increment = target / (duration / 16);
			let current = 0;

			const updateCounter = () => {
				current += increment;
				if (current < target) {
					counter.textContent = `${prefix}${Math.ceil(current).toLocaleString()}`;
					requestAnimationFrame(updateCounter);
				} else {
					counter.textContent = `${prefix}${target.toLocaleString()}`;
				}
			};

			updateCounter();
		});
	}
}


document.addEventListener('DOMContentLoaded', () => {
	NavigationSystem.init();
	ChartManager.init();
	ActivityManager.init();
	CounterAnimation.init();

	const settingsLink = document.querySelector('.dropdown-menu li:nth-child(2)');
	if (settingsLink) {
		settingsLink.addEventListener('click', () => {
			localStorage.setItem('lastAction', 'settings');
		});
	}
});document.addEventListener("DOMContentLoaded", function () {
    loadNotices(); // Load existing notices from database

    // Select Add Note button
    let addNoteBtn = document.querySelector(".add");
    if (!addNoteBtn) {
        console.error("Error: Add Note button not found!");
        return;
    }

    // Ensure correct .board-container is selected
    let noticeBoard = document.querySelector(".board-container");
    if (!noticeBoard) {
        console.error("Error: .board-container not found!");
        return;
    }

    // ✅ Add New Note
    addNoteBtn.addEventListener("click", function () {
        console.log("Add Note button clicked!");

        let newNote = document.createElement("div");
        newNote.classList.add("note");
        newNote.style.left = "50px";  // Default position
        newNote.style.top = "50px";  

        newNote.innerHTML = `
            <h4 class="title" contenteditable="true">New Title</h4>
            <textarea placeholder="Write something..."></textarea>
            <button class="save">Save</button>
            <button class="delete">Delete</button>
        `;

        noticeBoard.appendChild(newNote);
        makeDraggable(newNote); // Make the note draggable

        // ✅ Save button functionality
        newNote.querySelector(".save").addEventListener("click", function () {
            let title = newNote.querySelector(".title").innerText.trim();
            let content = newNote.querySelector("textarea").value.trim();

            if (title === "" || content === "") {
                alert("Title and content cannot be empty!");
                return;
            }

            // Send to the server
            fetch("NoticeServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `title=${encodeURIComponent(title)}&content=${encodeURIComponent(content)}&posX=50&posY=50`
            })
            .then(response => response.json())
            .then(() => {
                console.log("Notice added successfully!");
                loadNotices(); // Reload notices
            })
            .catch(error => console.error("Error adding notice:", error));
        });

        // ✅ Delete button functionality
        newNote.querySelector(".delete").addEventListener("click", function () {
            newNote.remove();
        });
    });
});

// ✅ Load Notices from Server
function loadNotices() {
    fetch("NoticeServlet")
        .then(response => response.json())
        .then(data => {
            let noticeBoard = document.querySelector(".board-container");
            if (!noticeBoard) {
                console.error("Error: .board-container not found.");
                return;
            }
            noticeBoard.innerHTML = ""; // Clear existing notices

            if (data.length === 0) {
                noticeBoard.innerHTML = "<p>No notices available.</p>";
                return;
            }

            data.forEach(notice => {
                let noticeDiv = document.createElement("div");
                noticeDiv.classList.add("note");
                noticeDiv.style.left = notice.posX + "px";
                noticeDiv.style.top = notice.posY + "px";

                noticeDiv.innerHTML = `
                    <h4 class="title" contenteditable="true">${notice.title}</h4>
                    <textarea>${notice.content}</textarea>
                    <button class="save">Save</button>
                    <button class="delete">Delete</button>
                `;
                
                noticeBoard.appendChild(noticeDiv);
                makeDraggable(noticeDiv);

                // ✅ Save button functionality
                noticeDiv.querySelector(".save").addEventListener("click", function () {
                    let title = noticeDiv.querySelector(".title").innerText.trim();
                    let content = noticeDiv.querySelector("textarea").value.trim();

                    fetch("NoticeServlet", {
                        method: "POST",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: `id=${notice.id}&title=${encodeURIComponent(title)}&content=${encodeURIComponent(content)}`
                    })
                    .then(() => console.log("Notice updated successfully!"))
                    .catch(error => console.error("Error updating notice:", error));
                });

                // ✅ Delete button functionality
                noticeDiv.querySelector(".delete").addEventListener("click", function () {
                    fetch("DeleteNoticeServlet", {
                        method: "POST",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: `id=${notice.id}`
                    })
                    .then(() => {
                        console.log("Notice deleted successfully!");
                        loadNotices(); // Reload notices
                    })
                    .catch(error => console.error("Error deleting notice:", error));
                });
            });
        })
        .catch(error => console.error("Error loading notices:", error));
}

// ✅ Make Notes Draggable
function makeDraggable(element) {
    let offsetX, offsetY, isDragging = false;

    element.addEventListener("mousedown", function (e) {
        isDragging = true;
        offsetX = e.clientX - element.getBoundingClientRect().left;
        offsetY = e.clientY - element.getBoundingClientRect().top;
        element.style.cursor = "grabbing";
    });

    document.addEventListener("mousemove", function (e) {
        if (!isDragging) return;
        element.style.left = e.clientX - offsetX + "px";
        element.style.top = e.clientY - offsetY + "px";
    });

    document.addEventListener("mouseup", function () {
        isDragging = false;
        element.style.cursor = "grab";
    });
}

document.getElementById("maintenance-form-section").addEventListener("submit", function(event) {
	console.log("Submitting form...");
	console.log("Action:", document.getElementById("actionType").value);
	console.log("ID:", document.getElementById("chargeId").value);
	console.log("Flat Size:", document.getElementById("flatSize").value);
	console.log("Amount:", document.getElementById("amount").value);
	console.log("Date Added:", document.getElementById("dateAdded").value);
});
function submitForm(action, id = null) {
	document.getElementById("actionType").value = action;

	if (id !== null) {
		document.getElementById("chargeId").value = id;
	}

	document.getElementById("maintenance-form-section").submit();
}
/* Custom Dragula JS */
dragula([
	document.getElementById("to-do"),
	document.getElementById("doing"),
	document.getElementById("done"),
	document.getElementById("trash")
]);
removeOnSpill: false
	.on("drag", function (el) {
		el.className.replace("ex-moved", "");
	})
	.on("drop", function (el) {
		el.className += "ex-moved";
	})
	.on("over", function (el, container) {
		container.className += "ex-over";
	})
	.on("out", function (el, container) {
		container.className.replace("ex-over", "");
	});

/* Vanilla JS to add a new task */
function addTask() {
	/* Get task text from input */
	var inputTask = document.getElementById("taskText").value;
	/* Add task to the 'To Do' column */
	document.getElementById("to-do").innerHTML +=
		"<li class='task'><p>" + inputTask + "</p></li>";
	/* Clear task text from input after adding task */
	document.getElementById("taskText").value = "";
}

/* Vanilla JS to delete tasks in 'Trash' column */
function emptyTrash() {
	/* Clear tasks from 'Trash' column */
	document.getElementById("trash").innerHTML = "";
}
