import axios from 'axios';

const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;

const axiosInstance = axios.create({
  headers: {
    'X-CSRF-Token': csrfToken,
    'Content-Type': 'application/json',
  },
});

// Optional: update token dynamically (e.g. if rendering changes)
axiosInstance.interceptors.request.use((config) => {
  const token = document.querySelector('meta[name="csrf-token"]')?.content;
  if (token) config.headers['X-CSRF-Token'] = token;
  return config;
});

export default axiosInstance;
