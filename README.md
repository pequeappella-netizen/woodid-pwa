# WoodID MVP 0.2

Segunda entrega técnica del prototipo.

## Qué añade v0.2
- Contrato `WoodClassifier` independiente de la interfaz.
- `MockWoodClassifier` para desarrollo.
- `ApiWoodClassifier` listo para enviar una imagen a `/v1/classify`.
- Modelos de resultado y Top-3.
- Contrato JSON del backend.
- Estructura inicial para construir el dataset de las 5 especies.
- Manifiesto CSV para controlar muestra, split, dispositivo y verificación.

## Estado actual
La UI de v0.1 sigue usando el resultado simulado. Los nuevos servicios dejan preparada la sustitución por un clasificador real.

## Próximo paso de IA
No conviene inventar un modelo sin datos. Primero hay que reunir o licenciar imágenes válidas y crear un test separado por ejemplar físico. Después se entrena el primer clasificador y se conecta a `ApiWoodClassifier`.

## Ejecutar la app
1. Instala Flutter estable.
2. Ejecuta `flutter create .`
3. Ejecuta `flutter pub get`
4. Configura permisos de cámara.
5. Ejecuta `flutter run` en un dispositivo físico.

## API esperada
POST `/v1/classify` como multipart/form-data, campo `image`.

Respuesta:
```json
{
  "model_version": "woodid-eu5-0.1",
  "predictions": [
    {"species_id": "quercus_robur", "confidence": 0.91}
  ]
}
```


## Novedades v0.3
- Investigación inicial de fuentes de imágenes.
- Protocolo de captura específico para fotografías reales de smartphone.
- Script de preparación que divide por `sample_id`, evitando que la misma pieza aparezca en entrenamiento y test.
- Manifiesto de adquisición listo para empezar a incorporar imágenes verificadas.

### Decisión técnica
Todavía NO incluimos pesos de un supuesto modelo "real": sin un conjunto de datos adecuado y un test independiente, una cifra de precisión sería engañosa. v0.3 deja preparado el pipeline correcto para entrenarlo y medirlo.


## Novedades v0.4
- Backend FastAPI ejecutable con `/health` y `/v1/classify`.
- Validación básica de formato, tamaño y resolución antes de clasificar.
- Respuesta explícita `is_simulated: true` para impedir confundir el mock con IA real.
- Plan formal de evaluación y rechazo de especies fuera del catálogo (open-set).
- Corrección de estrategia: SmartWoodID es excelente como referencia, pero su primera edición está centrada en la RDC; no asumimos cobertura de EU5.


## Novedades v0.5
- Control de calidad previo: resolución, exposición, contraste y proxy de nitidez.
- Respuesta `retake` cuando la foto no es adecuada.
- Cliente Flutter dedicado para conectar realmente con `/v1/classify`.
- URL del backend configurable con `--dart-define=WOODID_API_URL=...`.
- Plan de pruebas app ↔ API y privacidad.

### Ejecutar backend
```bash
cd backend
pip install -r requirements.txt
uvicorn server:app --reload --port 8000
```

### Ejecutar Flutter contra el backend
Android emulator:
```bash
flutter run --dart-define=WOODID_API_URL=http://10.0.2.2:8000
```

En teléfono físico hay que sustituir la URL por la IP LAN del ordenador de desarrollo.


## Novedades v0.6
- El escáner conserva la fotografía capturada y la envía realmente a la API.
- La UI procesa `retake` y muestra los motivos de calidad en ES/DE/IT/PT/EN.
- Manejo de error de conexión y reintento.
- Resultado generado desde la respuesta real de la API.
- El mock del backend sigue marcado visualmente como demostración; no se presenta como IA entrenada.

### Flujo integrado
Cámara → upload multipart → quality gate → repetir foto o Top-3 → historial.


## Novedades v0.7 — WoodID-EU5
- Pipeline reproducible de transfer learning.
- Baseline EfficientNet-B0.
- Augmentation para rotación, encuadre e iluminación.
- Evaluación separada sobre test.
- Balanced accuracy, Top-3, precision/recall y matriz de confusión.
- Exportación TorchScript.
- No se incluyen pesos falsos ni métricas inventadas: hacen falta imágenes reales verificadas para producirlos.


## Novedades v0.8 — Android test package
- Overlay de `AndroidManifest.xml` con cámara e Internet.
- Configuración de tráfico HTTP local para desarrollo.
- Script de preparación para Windows.
- Script de preparación para macOS/Linux.
- Scripts de arranque del backend.
- Guía paso a paso para emulador y teléfono Android físico.
- Instrucciones para compilar un APK debug.

Ver `PRUEBA_ANDROID.md`.
