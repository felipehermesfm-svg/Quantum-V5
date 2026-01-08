const { app, BrowserWindow } = require('electron');
const path = require('path');

function createMainWindow() {
  const win = new BrowserWindow({
    title: 'Quantum V5',
    width: 1280,
    height: 800,
    backgroundColor: '#000000',
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
    },
  });

  win.setMenuBarVisibility(false);

  // COLOQUE AQUI O LINK QUE FUNCIONA NO SEU NAVEGADOR
  // Remova qualquer "/" no final do link
  const vercelUrl = 'https://quantum-v5-hcmjxyblf-felipe-hermes-projects.vercel.app/';

  win.loadURL(vercelUrl).catch((err) => {
    console.error("Erro ao carregar URL:", err);
  });
}

app.whenReady().then(() => {
  createMainWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createMainWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});