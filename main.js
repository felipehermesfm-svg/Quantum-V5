const { app, BrowserWindow } = require('electron');

function createMainWindow() {
  const win = new BrowserWindow({
    title: 'Quantum V5',
    width: 1280,
    height: 800,
    backgroundColor: '#000000',
    show: false, // Só mostra quando carregar para evitar tela branca/404 rápido
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
    },
  });

  win.setMenuBarVisibility(false);

  // LINK DA VERCEL (Certifique-se de que é o link do "Production Deployment")
  const vercelUrl = 'https://quantum-v5.vercel.app';

  win.loadURL(vercelUrl);

  // Só mostra a janela quando o site responder com sucesso
  win.once('ready-to-show', () => {
    win.show();
  });

  // Se der erro 404 ou falha de rede, ele avisa no terminal do VS Code
  win.webContents.on('did-fail-load', (event, errorCode, errorDescription) => {
    console.log(`Erro de carregamento: ${errorDescription} (${errorCode})`);
    if (errorCode === -105 || errorCode === -102) {
      setTimeout(() => win.loadURL(vercelUrl), 5000);
    }
  });
}

app.whenReady().then(createMainWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});