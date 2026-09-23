# WoodID 0.8 — prueba en Android

## Necesitas
- Flutter instalado y `flutter doctor` razonablemente limpio.
- Android Studio.
- Python 3.
- Un emulador Android o un teléfono Android con depuración USB.

## Windows
Desde PowerShell, dentro de la carpeta WoodID:
```powershell
.\setup_android.ps1
```

## macOS / Linux
```bash
chmod +x setup_android.sh start_backend_mac_linux.sh
./setup_android.sh
```

## 1. Arranca el backend
Windows:
```text
start_backend_windows.bat
```

macOS/Linux:
```bash
./start_backend_mac_linux.sh
```

Comprueba en el navegador del ordenador:
`http://127.0.0.1:8000/health`

Debe responder con estado `ok`.

## 2. Emulador Android
```bash
flutter devices
flutter run --dart-define=WOODID_API_URL=http://10.0.2.2:8000
```

## 3. Teléfono Android físico
Activa Opciones de desarrollador + Depuración USB.
Conecta el teléfono y ejecuta:
```bash
flutter devices
```

Ordenador y teléfono deben poder comunicarse por la red local.
Busca la IP LAN del ordenador, por ejemplo `192.168.1.25`, y ejecuta:
```bash
flutter run --dart-define=WOODID_API_URL=http://192.168.1.25:8000
```

Si el firewall pregunta, permite Python/Uvicorn en la red privada.

## Qué probar
1. Inicio.
2. Cambio ES / DE / IT / PT / EN.
3. Cámara.
4. Foto correcta.
5. Foto intencionadamente oscura.
6. Foto desenfocada.
7. Resultado Top-3.
8. Historial.
9. Apaga el backend y comprueba el error de conexión/reintento.

## Importante
La comprobación de calidad sí se ejecuta sobre la foto enviada.
La identificación de especie continúa siendo SIMULADA hasta entrenar WoodID-EU5.
No uses todavía WoodID 0.8 para tomar decisiones sobre la especie real de una madera.

## Crear APK de desarrollo
Una vez funcione:
```bash
flutter build apk --debug --dart-define=WOODID_API_URL=http://TU_IP:8000
```
Flutter indicará la ubicación del APK generado.
