# Firebase

Guía de configuración y operación del backend de Diprovet.

## Proyecto actual

| Dato | Valor |
| --- | --- |
| Proyecto | `flutter-varios-38eb4` |
| Base de datos | Realtime Database |
| URL del catálogo | `https://flutter-varios-38eb4-default-rtdb.firebaseio.com/products.json` |
| Autenticación | Email/Password |
| Android package | `com.example.flutter_diprovet_cliente` |
| iOS bundle id | `com.erickvera.diprovet` |

Archivos generados que deben mantenerse sincronizados:

- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

> Los `apiKey` incluidos en estos archivos son identificadores públicos de
> cliente, no secretos de servidor. La seguridad real depende de las reglas de
> Firebase y de las restricciones de la API key.

## Requisitos en Firebase Console

1. **Authentication → Sign-in method**: habilitar **Email/Password**.
2. **Realtime Database**: crear la base de datos y aplicar reglas.
3. **Project settings → Your apps**: verificar que el paquete Android y el bundle
   id de iOS coincidan con los de la app.

## Modelo de datos

El catálogo se sirve como un objeto cuyas claves son los id de Firebase:

```json
{
  "products": {
    "-Nabc123": {
      "id": "-Nabc123",
      "name": "Vitamina B12",
      "specie": "Bovino",
      "category": "Materia Prima",
      "available": true,
      "picture": "https://ejemplo.com/vitamina-b12.png",
      "price": 12500,
      "description": "Suplemento inyectable.",
      "details": "Frasco por 100 ml.",
      "share": 3
    }
  }
}
```

Campos leídos por `Product.fromMap`:

| Campo | Tipo esperado | Notas |
| --- | --- | --- |
| `id` | string | Si falta, se usa cadena vacía |
| `name` | string | Valor por defecto: `Diprovet` |
| `specie` | string | **Se llama `specie` en el backend**, no `species` |
| `category` | string | Debe coincidir con una categoría visible |
| `available` | bool | Solo `true` se considera disponible |
| `picture` | string | URL de imagen |
| `price` | número o string numérico | Se convierte a `double`; inválido → `0` |
| `description` | string | Texto largo |
| `details` | string | Texto complementario |
| `share` | número o string numérico | Inválido o ausente → `0` |

Categorías visibles en la app (hardcodeadas en `ProductsProvider`):

- `Materia Prima`
- `Mascotas`
- `Agrícolas`
- `Desinfectante`
- `Relacionados`

Si agregas una categoría en Firebase, también debes agregarla en
`lib/logic/products_provider.dart` para que sea filtrable.

## Reglas de Realtime Database

Regla mínima recomendada para un catálogo de solo lectura pública:

```json
{
  "rules": {
    "products": {
      ".read": true,
      ".write": false
    }
  }
}
```

Las escrituras se hacen desde Firebase Console o con el Admin SDK, que omiten
las reglas. Si en el futuro una app administrativa escribe desde el cliente, no
basta con `auth != null`; usa custom claims o una lista de UID autorizados:

```json
{
  "rules": {
    "products": {
      ".read": true,
      ".write": "auth != null && auth.token.admin === true"
    }
  }
}
```

Cuando se persistan pedidos, una estructura inicial podría ser:

```json
{
  "orders": {
    "$uid": {
      "$orderId": {
        ".read": "auth.uid === $uid",
        ".write": "auth.uid === $uid",
        "createdAt": { ".validate": "newData.isNumber()" },
        "total": { ".validate": "newData.isNumber() && newData.val() >= 0" }
      }
    }
  }
}
```

Valida siempre los campos y evita permitir escrituras arbitrarias del cliente.

## Regenerar la configuración

Si cambias de proyecto o de identificadores:

```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=<project-id> --platforms=android,ios
```

El comando reescribe `lib/firebase_options.dart` y los archivos nativos. Revisa
que:

- `android/app/build.gradle` tenga el mismo `applicationId` registrado en
  Firebase.
- El `PRODUCT_BUNDLE_IDENTIFIER` de Xcode coincida con `iosBundleId` de
  `firebase_options.dart`.

## Inicialización en la app

`lib/main.dart` inicializa Firebase antes de montar la app:

```dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const MyApp());
```

`DefaultFirebaseOptions` solo admite Android e iOS. Si intentas ejecutar en web o
escritorio, lanzará `UnsupportedError` a propósito.

## Problemas frecuentes

| Síntoma | Solución |
| --- | --- |
| `[core/no-app] No Firebase App '[DEFAULT]' has been created` | Asegura la inicialización en `main.dart` y que no se llame a Firebase antes. |
| `PlatformException(channel-error)` en iOS | Ejecuta `cd ios && pod install` y vuelve a compilar. |
| `PERMISSION_DENIED` al leer productos | Revisa las reglas del nodo `products`. |
| `DefaultFirebaseOptions have not been configured for web` | La app solo soporta Android/iOS. |
| Login falla con `operation-not-allowed` | Habilita Email/Password en Authentication. |
| El catálogo carga vacío | Verifica la URL regional de la base de datos y que el nodo se llame `products`. |
| `email-already-in-use` al registrarse | El correo ya existe; usa “Iniciar sesión”. |
| Error de paquete Android | El `applicationId` debe coincidir con el registrado en Firebase. |

## Verificación rápida

```bash
# Leer el catálogo como lo hace la app
curl "https://flutter-varios-38eb4-default-rtdb.firebaseio.com/products.json"

# Análisis y pruebas locales
flutter analyze
flutter test
```
