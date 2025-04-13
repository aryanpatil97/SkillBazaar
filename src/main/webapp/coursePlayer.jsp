<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBazaar - ${course.title}</title>
    <link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F7FA;
            color: #333333;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            background-color: #F5F7FA;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        .logo img {
            height: 60px;
        }
        .nav-links {
            display: flex;
            align-items: center;
        }
        .nav-links a {
            color: #333333;
            text-decoration: none;
            margin: 0 20px;
            font-size: 16px;
            font-weight: 500;
        }
        .nav-links a:hover {
            color: #00C4B4;
        }
        .dropdown {
            position: relative;
            display: inline-block;
        }
        .dropbtn {
            display: flex;
            align-items: center;
            color: #333333;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #FFFFFF;
            min-width: 160px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            z-index: 1;
            border-radius: 5px;
        }
        .dropdown-content a {
            color: #333333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-size: 14px;
        }
        .dropdown-content a:hover {
            background-color: #00C4B4;
            color: #FFFFFF;
        }
        .dropdown:hover .dropdown-content {
            display: block;
        }
        .auth-buttons {
            display: flex;
            align-items: center;
        }
        .auth-buttons a {
            color: #333333;
            text-decoration: none;
            margin-left: 15px;
            padding: 8px 20px;
            border: 1px solid #00C4B4;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .auth-buttons a:hover {
            background-color: #00C4B4;
            color: #FFFFFF;
        }
        .cart-icon {
            position: relative;
            margin-left: 20px;
        }
        .cart-count {
            position: absolute;
            top: -10px;
            right: -10px;
            background-color: #00C4B4;
            color: #FFFFFF;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
        .course-player-section {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
        }
        .course-player-section h2 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 20px;
        }
        .course-info p {
            font-size: 16px;
            color: #666666;
            margin-bottom: 10px;
        }
        .video-player {
            margin: 20px 0;
            position: relative;
            padding-bottom: 56.25%; /* 16:9 aspect ratio */
            height: 0;
            overflow: hidden;
        }
        .video-player iframe, .video-player div {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .progress-bar {
            width: 100%;
            height: 10px;
            background-color: #E0E0E0;
            border-radius: 5px;
            overflow: hidden;
            margin-top: 10px;
        }
        .progress {
            height: 100%;
            background-color: #00C4B4;
            width: ${progress}%;
            transition: width 0.3s ease;
        }
        .progress-text {
            font-size: 14px;
            color: #666666;
            margin-top: 5px;
        }
        .error-message {
            color: #FF0000;
            font-size: 14px;
            margin-top: 10px;
        }
        footer {
            background-color: #F5F7FA;
            color: #666666;
            text-align: center;
            padding: 20px;
            border-top: 1px solid #E0E0E0;
            margin-top: 50px;
        }
        footer a {
            color: #00C4B4;
            text-decoration: none;
            margin: 0 10px;
        }
        .project-note {
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <a href="home"><img src="assets/logos/skillbazaar.png" alt="SkillBazaar Logo"></a>
        </div>
        <div class="nav-links">
            <a href="allCourses">Courses</a>
            <div class="dropdown">
                <div class="dropbtn">Categories <span>▼</span></div>
                <div class="dropdown-content">
                    <c:forEach var="category" items="${categories}">
                        <a href="coursesByCategory?category=${category}">${category}</a>
                    </c:forEach>
                </div>
            </div>
            <a href="myLearning">My Learning</a>
            <div class="auth-buttons">
                <span>Welcome, ${sessionScope.userName}</span>
                <a href="logout">Logout</a>
                <div class="cart-icon">
                    <a href="cart.jsp">[Cart]</a>
                    <span class="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                </div>
            </div>
        </div>
    </header>

    <section class="course-player-section">
        <h2>${course.title}</h2>
        <div class="course-info">
            <p><strong>Instructor:</strong> ${course.instructor}</p>
            <p><strong>Description:</strong> ${course.description}</p>
            <p><strong>Category:</strong> ${course.category}</p>
        </div>
        <div class="video-player">
            <div id="player"></div>
            <iframe id="fallback-player" src="" allow="autoplay; encrypted-media" allowfullscreen style="display: none;"></iframe>
        </div>
        <div id="error-message" class="error-message"></div>
        <div class="progress-bar">
            <div class="progress" id="progress-bar"></div>
        </div>
        <p class="progress-text">Progress: <span id="progress-text">${progress}</span>%</p>
    </section>

    <footer>
        <p>© 2025 SkillBazaar. All rights reserved.</p>
        <p class="project-note">A project by N-Infinity Info Solutions under the guidance of Prof. Prasad Sase.</p>
        <a href="#">About</a>
        <a href="#">Contact</a>
        <a href="#">Privacy Policy</a>
    </footer>

    <script>
        console.log('Script started');
        let player;
        let progressInterval;
        const courseId = ${course.courseId};
        let currentProgress = ${progress};
        const videoUrl = '${course.videoUrl}';
        console.log('Course ID:', courseId);
        console.log('Initial Progress:', currentProgress);
        console.log('Video URL:', videoUrl);

        // Validate courseId and progress
        if (!courseId || isNaN(courseId)) {
            console.error('Invalid courseId:', courseId);
            document.getElementById('error-message').textContent = 'Error: Invalid course ID.';
            return;
        }

        if (isNaN(currentProgress)) {
            console.error('Invalid initial progress:', currentProgress);
            currentProgress = 0;
        }

        // Extract video ID and set up fallback
        const videoId = extractVideoId(videoUrl);
        if (!videoId) {
            console.error('Invalid video ID, using fallback');
            useFallbackPlayer(videoUrl);
        } else {
            console.log('Video ID extracted:', videoId);
            // Always set the fallback player src, but keep it hidden
            document.getElementById('fallback-player').src = https://www.youtube.com/embed/${videoId}?enablejsapi=1;
            initializeYouTubePlayer(videoId);
        }

        function extractVideoId(url) {
            console.log('Extracting video ID from URL:', url);
            const regex = /(?:v=)([a-zA-Z0-9_-]{11})/;
            const match = url.match(regex);
            if (!match) {
                console.error('Invalid YouTube URL:', url);
                return '';
            }
            return match[1];
        }

        function useFallbackPlayer(url) {
            console.log('Using fallback player with URL:', url);
            const videoId = url.split('v=')[1]?.split('&')[0];
            if (videoId) {
                document.getElementById('player').style.display = 'none';
                document.getElementById('fallback-player').style.display = 'block';
                document.getElementById('fallback-player').src = https://www.youtube.com/embed/${videoId};
                document.getElementById('error-message').textContent = 'Using fallback player due to API failure. Progress tracking is disabled.';
            } else {
                document.getElementById('error-message').textContent = 'Error: Unable to load video.';
            }
        }

        function initializeYouTubePlayer(videoId) {
            console.log('Initializing YouTube player with video ID:', videoId);

            // Load YouTube IFrame API
            if (!document.getElementById('youtube-api-script')) {
                console.log('Loading YouTube IFrame API');
                const tag = document.createElement('script');
                tag.src = "https://www.youtube.com/iframe_api";
                tag.id = "youtube-api-script";
                tag.onerror = function() {
                    console.error('Failed to load YouTube IFrame API script');
                    useFallbackPlayer(videoUrl);
                };
                const firstScriptTag = document.getElementsByTagName('script')[0];
                firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
            } else {
                console.log('YouTube IFrame API script already present');
                if (window.YT && window.YT.Player) {
                    console.log('YouTube API already loaded, creating player');
                    createPlayer(videoId);
                }
            }

            window.onYouTubeIframeAPIReady = function() {
                console.log('YouTube IFrame API ready');
                createPlayer(videoId);
            };
        }

        function createPlayer(videoId) {
            console.log('Creating YouTube player with video ID:', videoId);
            try {
                // Destroy existing player if any
                if (player) {
                    console.log('Destroying existing player');
                    player.destroy();
                    player = null;
                }

                player = new YT.Player('player', {
                    height: '100%',
                    width: '100%',
                    videoId: videoId,
                    playerVars: {
                        'playsinline': 1,
                        'enablejsapi': 1,
                        'rel': 0,
                        'showinfo': 0,
                        'autoplay': 0
                    },
                    events: {
                        'onReady': onPlayerReady,
                        'onStateChange': onPlayerStateChange,
                        'onError': onPlayerError
                    }
                });
                console.log('Player created successfully');
            } catch (e) {
                console.error('Error creating YouTube player:', e);
                useFallbackPlayer(videoUrl);
            }
        }

        function onPlayerReady(event) {
            console.log('YouTube player is ready');
            document.getElementById('progress-bar').style.width = currentProgress + '%';
            document.getElementById('progress-text').textContent = currentProgress;

            if (currentProgress > 0 && currentProgress < 100) {
                seekToLastPosition();
            }
        }

        function seekToLastPosition() {
            console.log('Seeking to last position');
            const duration = player.getDuration();
            if (duration) {
                const seekTo = (currentProgress / 100) * duration;
                player.seekTo(seekTo, true);
                console.log('Seeked to:', seekTo, 'seconds');
            } else {
                console.warn('Video duration not available yet, retrying...');
                setTimeout(seekToLastPosition, 500);
            }
        }

        function onPlayerStateChange(event) {
            console.log('Player state changed:', event.data);
            if (event.data == YT.PlayerState.PLAYING) {
                console.log('Video is playing, starting progress tracking');
                progressInterval = setInterval(updateProgress, 5000); // Update every 5 seconds
            } else if (event.data == YT.PlayerState.ENDED) {
                console.log('Video ended');
                clearInterval(progressInterval);
                currentProgress = 100;
                document.getElementById('progress-bar').style.width = '100%';
                document.getElementById('progress-text').textContent = '100';
                sendProgressToServer(100);
            } else {
                console.log('Video paused or stopped, stopping progress tracking');
                clearInterval(progressInterval);
            }
        }

        function onPlayerError(event) {
            console.error('YouTube Player Error:', event.data);
            document.getElementById('error-message').textContent = 'Error loading video: ' + event.data;
            useFallbackPlayer(videoUrl);
        }

        function updateProgress() {
            if (!player || !player.getCurrentTime || !player.getDuration) {
                console.warn('Player not fully initialized for progress update.');
                return;
            }

            const currentTime = player.getCurrentTime();
            const duration = player.getDuration();
            if (!duration) {
                console.warn('Duration not available.');
                return;
            }

            const progress = Math.min(100, Math.round((currentTime / duration) * 100));
            console.log('Calculated progress:', progress, '% (Current Time:', currentTime, 'Duration:', duration, ')');

            document.getElementById('progress-bar').style.width = progress + '%';
            document.getElementById('progress-text').textContent = progress;

            if (progress > currentProgress) {
                currentProgress = progress;
                sendProgressToServer(progress);
            }
        }

        function sendProgressToServer(progress) {
            if (!courseId || isNaN(courseId)) {
                console.error('Cannot send progress: Invalid courseId:', courseId);
                return;
            }
            if (isNaN(progress)) {
                console.error('Cannot send progress: Invalid progress:', progress);
                return;
            }

            console.log('Sending progress to server - Course ID:', courseId, 'Progress:', progress);
            const data = courseId=${courseId}&progress=${progress};
            console.log('Request body:', data);

            fetch('updateProgress', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: data
            })
            .then(response => {
                console.log('Fetch response status:', response.status);
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (!data.success) {
                    console.error('Error updating progress:', data.message);
                } else {
                    console.log('Progress updated successfully:', progress + '%');
                }
            })
            .catch(error => {
                console.error('Error sending progress:', error);
            });
        }

        window.onbeforeunload = function() {
            clearInterval(progressInterval);
            if (player) {
                player.destroy();
            }
        };
    </script>
</body>
</html>