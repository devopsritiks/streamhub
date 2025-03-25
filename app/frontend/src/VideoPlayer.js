import React, { useEffect, useRef } from 'react';
import videojs from 'video.js';
import 'video.js/dist/video-js.css';

function VideoPlayer({ url }) {
  const videoRef = useRef(null);
  const playerRef = useRef(null);

  useEffect(() => {
    // Initialize Video.js player
    playerRef.current = videojs(videoRef.current, {
      controls: true,
      autoplay: false,
      preload: 'auto',
      fluid: true,
      sources: [{ src: url, type: 'video/mp4' }]
    });

    return () => {
      if (playerRef.current) {
        playerRef.current.dispose(); // Clean up player on unmount
      }
    };
  }, [url]);

  return (
    <div>
      <video ref={videoRef} className="video-js vjs-default-skin" />
    </div>
  );
}

export default VideoPlayer;
