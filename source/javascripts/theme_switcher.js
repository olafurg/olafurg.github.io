(function() {
  const themeButtons = {
    light: document.getElementById('theme-light'),
    dark: document.getElementById('theme-dark'),
    system: document.getElementById('theme-system')
  };

  const setTheme = (theme, save = true) => {
    if (save) {
      localStorage.setItem('theme', theme);
    }

    // Process dark mode application
    const isDark = theme === 'dark' || (theme === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches);

    if (isDark) {
      document.documentElement.setAttribute('data-theme', 'dark');
    } else {
      document.documentElement.removeAttribute('data-theme');
    }

    // Update button states
    Object.keys(themeButtons).forEach(key => {
      if (themeButtons[key]) {
        themeButtons[key].classList.toggle('active', key === theme);
      }
    });
  };

  // Initial state
  const savedTheme = localStorage.getItem('theme') || 'system';
  setTheme(savedTheme, false);

  // Click listeners
  Object.keys(themeButtons).forEach(theme => {
    if (themeButtons[theme]) {
      themeButtons[theme].addEventListener('click', () => setTheme(theme));
    }
  });

  // Listen for system theme changes
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
    if (localStorage.getItem('theme') === 'system' || !localStorage.getItem('theme')) {
      setTheme('system', false);
    }
  });
})();
