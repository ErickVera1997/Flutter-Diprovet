# Contribuir

Gracias por trabajar en el cliente móvil de Diprovet. Esta guía resume el flujo
de trabajo y los criterios mínimos para integrar cambios.

## Preparación del entorno

```bash
git clone https://github.com/ErickVera1997/Flutter-Diprovet.git
cd Flutter-Diprovet
fvm install
fvm flutter pub get
fvm flutter run
```

Si no usas FVM, necesitas Flutter **≥ 3.27** (el proyecto fija 3.47.6 en
`.fvmrc`).

## Ramas

Se trabaja sobre `develop`; `main` representa una versión estable.

| Tipo | Patrón | Ejemplo |
| --- | --- | --- |
| Funcionalidad | `feat/descripcion` | `feat/persistencia-carrito` |
| Corrección | `fix/descripcion` | `fix/total-carrito` |
| Documentación | `docs/descripcion` | `docs/readme` |
| Refactor | `refactor/descripcion` | `refactor/product-card` |
| Mantenimiento | `chore/descripcion` | `chore/actualizar-deps` |

```bash
git checkout develop
git pull origin develop
git checkout -b feat/mi-cambio
```

## Commits

Se usa [Conventional Commits](https://www.conventionalcommits.org/) con
descripción en español, en imperativo y sin punto final:

```text
<tipo>(<alcance opcional>): <descripción>

[cuerpo opcional]

[footer opcional]
```

Tipos permitidos:

- `feat`: nueva funcionalidad visible para el usuario.
- `fix`: corrección de un defecto.
- `docs`: cambios solo de documentación.
- `test`: pruebas nuevas o ajustes de pruebas.
- `refactor`: cambio interno sin alterar comportamiento.
- `chore`: configuración, dependencias o mantenimiento.
- `perf`: mejora de rendimiento.

Ejemplos:

```text
fix(carrito): identificar productos por id en lugar de nombre
feat(catalogo): mostrar error y botón de reintento
docs: documentar arquitectura y configuración de Firebase
test(logica): cubrir totales y cantidades del carrito
```

Buenas prácticas:

- Un commit debe tener una intención clara y el proyecto debe compilar.
- No mezcles refactors grandes con correcciones funcionales.
- No incluyas archivos generados (`.dart_tool/`, `build/`, `.fvm/`).
- No subas credenciales de servidor ni service accounts de Firebase.

## Estilo de código

El proyecto usa `very_good_analysis`. Antes de abrir un PR:

```bash
dart format lib test
fvm flutter analyze
fvm flutter test
```

Criterios:

- 80 columnas.
- `const` siempre que sea posible.
- Comas finales en constructores y listas multilínea.
- Un widget público por archivo, con `key` en el constructor.
- `snake_case` para archivos y `PascalCase` para clases.
- Los servicios devuelven `Either<String, T>`; no lanzan excepciones hacia la UI.
- Los modelos toleran datos incompletos (`fromMap` no debe lanzar).
- Los precios se muestran con `formatCurrency` de `lib/core/utils.dart`.

## Pruebas

- Cambios en `lib/logic` o `lib/core` requieren pruebas unitarias.
- Cambios en widgets reutilizables requieren pruebas de widget.
- Usa `ProductsProvider(autoLoad: false)` para inyectar servicios falsos.
- Los tests no deben depender de red ni de Firebase real.

```bash
fvm flutter test
fvm flutter test test/logic/shopping_provider_test.dart
```

## Documentación

Actualiza la documentación cuando cambies:

- Rutas o guard de sesión → `docs/ARCHITECTURE.md`.
- Esquema de datos, reglas o configuración → `docs/FIREBASE.md`.
- Comandos, requisitos o estructura → `README.md`.
- Nuevas dependencias relevantes → `README.md` (stack) y `pubspec.yaml`.

## Checklist de PR

- [ ] La rama parte de `develop` actualizado.
- [ ] `dart format --set-exit-if-changed lib test` pasa.
- [ ] `flutter analyze` no reporta issues.
- [ ] `flutter test` pasa.
- [ ] Se agregaron pruebas para la lógica nueva.
- [ ] La UI maneja carga, error y estado vacío.
- [ ] No hay `!` sobre datos que puedan faltar.
- [ ] No se commitean archivos generados ni secretos.
- [ ] La documentación quedó actualizada.
- [ ] El PR describe el problema, la solución y cómo probarlo.

## Seguridad

- Las API keys de Firebase en `lib/firebase_options.dart` son identificadores de
  cliente; aun así, restringe la API key en Google Cloud.
- Las reglas de Realtime Database son la verdadera autorización.
- Nunca agregues archivos de service account, `.env` con secretos ni
  credenciales de administrador.
- Si detectas una exposición, avisa al equipo antes de abrir un issue público.

## Contacto

Para dudas de producto o acceso a Firebase, contacta al responsable del proyecto
en el repositorio.
