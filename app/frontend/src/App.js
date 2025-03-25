import React, { useState, useEffect } from 'react';
import axios from 'axios';
import VideoPlayer from './VideoPlayer';

function App() {
  const [videos, setVideos] = useState([]);
  const [selectedVideo, setSelectedVideo] = useState(null);

  useEffect(() => {
    // Fetch video list from backend (to be updated with actual backend URL)
    axios.get('http://localhost:5000/videos') // Replace with backend service URL later
      .then(response => {
        setVideos(response.data);
        setSelectedVideo(response.data[0]); // Default to first video
      })
      .catch(error => console.error('Error fetching videos:', error));
  }, []);

  const handleVideoSelect = (video) => {
    setSelectedVideo(video);
  };

  return (
    <div className="app">
      <h1>StreamHub</h1>
      <div className="content">
        <div className="video-player">
          {selectedVideo ? (
            <VideoPlayer url={selectedVideo.url} />
          ) : (
            <p>Loading video...</p>
          )}
        </div>
        <div className="video-list">
          <h2>Available Videos</h2>
          <ul>
            {videos.map(video => (
              <li
                key={video.id}
                onClick={() => handleVideoSelect(video)}
                className={selectedVideo && selectedVideo.id === video.id ? 'active' : ''}
              >
                {video.title}
              </li>
            ))}
          </ul>
        </div>
      </div>
    </div>
  );
}

export default App;
