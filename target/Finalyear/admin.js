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
});

document.addEventListener("DOMContentLoaded", () => {
	const boardContainer = document.querySelector('#settings-content .board .board-container'); // Ensure correct selector for board container
	const addButton = document.querySelector('#settings-content .board .add');

	// Check if the boardContainer exists in the DOM
	if (!boardContainer) {
		console.error("Board container not found.");
		return;
	}

	// Load existing notices from the database
	fetch("GetNoticesServlet")
		.then(response => response.json())
		.then(data => {
			data.forEach(notice => {
				createNote(notice.id, notice.title, notice.content, notice.posX, notice.posY);
			});
		})
		.catch(error => {
			console.error("Error loading notices:", error);
		});

	function makeNoteDraggable(note) {
		let isDragging = false;
		let offsetX, offsetY;

		note.addEventListener("mousedown", (e) => {
			isDragging = true;
			offsetX = e.offsetX;
			offsetY = e.offsetY;
			note.style.cursor = "grabbing";
		});

		document.addEventListener("mousemove", (e) => {
			if (!isDragging) return;

			const boardRect = boardContainer.getBoundingClientRect();
			const newLeft = e.clientX - boardRect.left - offsetX;
			const newTop = e.clientY - boardRect.top - offsetY;

			// Prevent dragging out of the board
			note.style.left = `${Math.max(0, Math.min(boardRect.width - note.offsetWidth, newLeft))}px`;
			note.style.top = `${Math.max(0, Math.min(boardRect.height - note.offsetHeight, newTop))}px`;
		});

		document.addEventListener("mouseup", () => {
			isDragging = false;
			note.style.cursor = "grab";

			// Update position in the database
			fetch("/Finalyear/NoticeServlet", {
				method: "POST",
				headers: { "Content-Type": "application/x-www-form-urlencoded" },
				body: new URLSearchParams({
					id: note.dataset.id || "", // Ensure it's not undefined
					title: note.dataset.title || "Default Title", // Provide a fallback
					content: note.dataset.content || "Default Content",
					posX: note.offsetLeft,
					posY: note.offsetTop
				})
			});

		});
	}

	function createNote(id = null, title = "New Title", content = "New Content", posX = 50, posY = 50) {
		const note = document.createElement("div");
		note.className = "note";
		note.dataset.id = id || Date.now();
		note.style.top = `${posY}px`;
		note.style.left = `${posX}px`;

		note.innerHTML = `
            <div class="title">${title}</div>
            <textarea class="title-edit" style="display: none;">${title}</textarea>
            <p>${content}</p>
            <textarea class="content-edit" style="display: none;">${content}</textarea>
            <button class="edit">Edit</button>
            <button class="save" style="display: none;">Save</button>
            <button class="delete">X</button>
        `;

		// Edit event
		note.querySelector(".edit").addEventListener("click", () => {
			note.querySelector(".title").style.display = "none";
			note.querySelector(".title-edit").style.display = "block";
			note.querySelector("p").style.display = "none";
			note.querySelector(".content-edit").style.display = "block";
			note.querySelector(".edit").style.display = "none";
			note.querySelector(".save").style.display = "inline-block";
		});

		// Save event
		note.querySelector(".save").addEventListener("click", () => {
			const updatedTitle = note.querySelector(".title-edit").value;
			const updatedContent = note.querySelector(".content-edit").value;

			fetch("NoticeServlet", {
				method: "POST",
				headers: { "Content-Type": "application/x-www-form-urlencoded" },
				body: `id=${note.dataset.id}&title=${updatedTitle}&content=${updatedContent}&posX=${note.offsetLeft}&posY=${note.offsetTop}`
			}).then(() => {
				note.querySelector(".title").textContent = updatedTitle;
				note.querySelector("p").textContent = updatedContent;
				note.querySelector(".title").style.display = "block";
				note.querySelector(".title-edit").style.display = "none";
				note.querySelector("p").style.display = "block";
				note.querySelector(".content-edit").style.display = "none";
				note.querySelector(".edit").style.display = "inline-block";
				note.querySelector(".save").style.display = "none";
			});
		});

		// Delete event
		note.querySelector(".delete").addEventListener("click", () => {
			fetch("DeleteNoticeServlet", {
				method: "POST",
				headers: { "Content-Type": "application/x-www-form-urlencoded" },
				body: `id=${note.dataset.id}`
			}).then(() => boardContainer.removeChild(note));
		});

		boardContainer.appendChild(note);
		makeNoteDraggable(note);
	}

	// Add new note on button click
	addButton.addEventListener("click", () => {
		console.log("Add button clicked");

		fetch("NoticeServlet", {
			method: "POST",
			headers: { "Content-Type": "application/x-www-form-urlencoded" },
			body: "title=New Title&content=New Content&posX=50&posY=50"
		})
			.then(response => {
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				return response.json();
			})
			.then(data => {
				console.log('Created new notice:', data);
				createNote(data.id, data.title, data.content, 50, 50);
			})
			.catch(error => {
				console.error("Error creating notice:", error);
			});
	});
});
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
