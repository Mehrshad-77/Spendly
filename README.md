<h1 align="center">SPENDLY</h1>

<p align="center">
  A personal expense tracker with exact decimal money math — use it as a terminal app or a local web app, both backed by the same core.
</p>

<p align="center">
  <img alt="Python 3.11+" src="https://img.shields.io/badge/python-3.11%2B-blue">
  <img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-green">
  <img alt="Tests: 43 passing" src="https://img.shields.io/badge/tests-43%20passing-brightgreen">
</p>

---

## Features

- **Two interfaces, one core** — an interactive terminal CLI (`main.py`) and a FastAPI + HTML/JS web app (`api.py`), both built on the same `ExpenseTracker` class so behavior never drifts between them
- **Exact money math** — amounts are `Decimal` end-to-end on the backend and integer cents in the frontend, so totals never accumulate floating-point rounding errors
- **Full CRUD** — add, edit, and delete expenses, or wipe everything and start fresh
- **Search & filter** — case/whitespace-insensitive name search, and filtering by category, month, or both
- **Spending totals** — total spend for a given month/year or a given category
- **Sortable views** — by date, amount, or name, ascending or descending
- **Persistent storage** — CSV-backed, with safe handling of malformed rows and I/O errors
- **Self-contained web app** — the FastAPI backend serves the frontend directly at `/`, so there's no separate origin, no CORS setup, and no build step

## Tech stack

- **Language:** Python
- **API:** FastAPI + Pydantic, served with Uvicorn
- **Storage:** CSV, with `decimal.Decimal` for exact currency arithmetic
- **Frontend:** Vanilla HTML/CSS/JS — no framework, no build step, served directly by FastAPI
- **Desktop:** pywebview (native window around the web app), packaged with PyInstaller and Inno Setup
- **Testing:** pytest (core logic + CLI) and FastAPI's `TestClient` (API)

## Getting started

```bash
# Clone the repo
git clone https://github.com/Mehrshad-77/Spendly.git
cd Spendly

# Create and activate a virtual environment
python -m venv venv
source venv/bin/activate       # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Run the CLI

```bash
python main.py
```

### Run the web app

```bash
uvicorn api:app --reload
```

Then open **http://127.0.0.1:8000** — the API and frontend are served from the same app, so nothing else needs to run.

### Run the desktop app

```bash
python desktop.py
```

Opens the same web app in a native window. If no GUI backend is available (e.g. GTK/Qt aren't installed), it falls back to running headless in the terminal — press Ctrl+C to stop.

## Building a Windows executable

```bash
pip install pyinstaller
pyinstaller pyinstaller\windows.spec
```

The built app will be in `pyinstaller\dist\Spendly.exe`.

## Building the installer

Requires [Inno Setup](https://jrsoftware.org/isinfo.php) and the `.exe` above already built.

```bash
iscc installer\setup.iss
```

The installer will be in `installer\dist\Spendly-Setup-1.0.0.exe`.

## Running tests

```bash
pytest test_tracker.py    # core tracker logic — 19 tests
python test_api.py        # API endpoints — 24 tests
```

## Project structure

```
Spendly/
├── main.py                        # Interactive terminal CLI
├── tracker.py                     # ExpenseTracker — storage & business logic (CSV, Decimal math)
├── api.py                         # FastAPI app — REST endpoints, serves the web frontend
├── desktop.py                     # pywebview desktop wrapper around the web app
├── expense-tracker-preview.html   # Web frontend (vanilla HTML/CSS/JS)
├── pyinstaller/
│   └── windows.spec                # PyInstaller build spec for the desktop app
├── installer/
│   └── setup.iss                   # Inno Setup script for the Windows installer
├── test_tracker.py                # pytest suite for tracker.py / CLI logic
├── test_api.py                    # FastAPI TestClient suite for api.py
└── requirements.txt
```

## Roadmap

- [x] Wrap the built `.exe` in an Inno Setup installer (Start Menu shortcut, uninstaller)

## License

MIT — see [LICENSE](LICENSE).