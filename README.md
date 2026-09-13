<div align="center">
  <table>
    <tr>
      <td valign="middle" style="border: none; padding-right: 18px;">
        <img src="assets/spendly-icon-128.png" alt="Spendly wallet logo" width="96">
      </td>
      <td valign="middle" style="border: none;">
        <h1>Spendly</h1>
        <p><strong>Track your spending. Stay in control.</strong></p>
      </td>
    </tr>
  </table>

  <p>A lightweight personal expense tracker built with Python, FastAPI, and a vanilla HTML/CSS/JavaScript frontend.</p>

  <p>
    <img alt="Python 3.13" src="https://img.shields.io/badge/Python-3.13+-3776AB?logo=python&logoColor=white">
    <img alt="FastAPI" src="https://img.shields.io/badge/FastAPI-0.110+-009688?logo=fastapi&logoColor=white">
    <img alt="License MIT" src="https://img.shields.io/badge/License-MIT-0F5132">
  </p>
</div>

---

## Overview

**Spendly** is a personal expense tracker designed as a practical Python software-engineering project. It provides both an interactive command-line interface and a local web application while keeping the core expense logic in a shared `ExpenseTracker` class.

The project focuses on clean separation of concerns, persistent data, exact monetary calculations, API design, validation, testing, and a simple user interface without introducing a frontend framework or build system.

## Features

- **Expense management** — add, edit, delete, and delete all expenses.
- **Categories** — Food, Transport, Entertainment, Education, Bills, and Other.
- **Search** — find expenses by name.
- **Filtering** — filter expenses by category or month.
- **Sorting** — sort expenses by date, value, or name in ascending or descending order in the CLI.
- **Spending summaries** — calculate total spending for a month/year or category.
- **Exact money calculations** — backend amounts use Python's `Decimal` instead of binary floating-point arithmetic.
- **Persistent storage** — expenses are stored in a CSV file in the user's OS-specific application-data directory.
- **REST API** — FastAPI endpoints expose the expense-management functionality.
- **Web interface** — the frontend is served directly by FastAPI; no separate frontend server or build step is required.
- **Desktop app support** — the project includes a `pywebview` desktop wrapper and Windows packaging configuration.
- **Automated tests** — tests cover the tracker logic and API behavior.

## Tech stack

| Layer | Technology |
|---|---|
| Language | Python |
| API | FastAPI + Pydantic |
| Server | Uvicorn |
| Desktop wrapper | pywebview |
| Storage | CSV |
| Money | `decimal.Decimal` |
| Frontend | HTML, CSS, JavaScript |
| Testing | pytest + FastAPI `TestClient` |
| Packaging | PyInstaller + Inno Setup |

## Project structure

```text
Spendly/
├── assets/
│   └── spendly-icon*.png          # Spendly wallet/app icon assets
├── packaging/
│   ├── spendly.ico               # Windows application icon
│   ├── spendly.spec              # PyInstaller configuration
│   └── Spendly.iss               # Inno Setup installer configuration
├── api.py                         # FastAPI application and REST endpoints
├── desktop.py                     # pywebview desktop application wrapper
├── expense-tracker-preview.html   # Web frontend
├── main.py                        # Interactive CLI
├── tracker.py                     # Expense model, storage, and business logic
├── test_api.py                    # API tests
├── test_tracker.py                # Tracker/CLI tests
├── requirements.txt               # Python dependencies
├── Tracker.csv                    # Local/sample expense data
├── LICENSE                        # MIT license
└── README.md
```

## Getting started

### 1. Clone the repository

```bash
git clone https://github.com/Mehrshad-77/ExpenseTracker.git
cd ExpenseTracker
```

### 2. Create a virtual environment

**Windows PowerShell:**

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
```

**macOS / Linux:**

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install dependencies

```bash
python -m pip install -r requirements.txt
```

## Run Spendly

### 1. Desktop app

Spendly includes a `pywebview` desktop wrapper that opens the application in a native desktop window.

Run:

```bash
python desktop.py
```

This starts the local API automatically and launches the Spendly interface as a desktop application.

### 2. Web app

Start the FastAPI server:

```bash
uvicorn api:app --reload
```

Then open:

```text
http://127.0.0.1:8000
```

The frontend is served directly by FastAPI, so no separate frontend development server is required.

### 3. FastAPI

You can run Spendly as an API service independently with:

```bash
uvicorn api:app --reload
```

The interactive API documentation is available at:

```text
http://127.0.0.1:8000/docs
```

The API provides endpoints for managing expenses, categories, filtering, and spending summaries.

### 4. Terminal CLI

Run the interactive terminal version with:

```bash
python main.py
```

The CLI provides expense management, searching, filtering, sorting, and spending-summary functionality.

## API

The FastAPI application exposes endpoints for the main expense operations.

| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/` | Serve the Spendly frontend |
| `GET` | `/categories` | Get supported categories |
| `GET` | `/expenses` | List expenses |
| `POST` | `/expenses` | Create an expense |
| `PATCH` | `/expenses/{id}` | Edit an expense |
| `DELETE` | `/expenses/{id}` | Delete an expense |
| `DELETE` | `/expenses` | Delete all expenses |
| `GET` | `/expenses/search` | Search by expense name |
| `GET` | `/expenses/filter` | Filter by category/month |
| `GET` | `/expenses/spending/month` | Calculate monthly spending |
| `GET` | `/expenses/spending/category` | Calculate category spending |

FastAPI also provides interactive API documentation while the server is running:

```text
http://127.0.0.1:8000/docs
```

## Data storage

Spendly uses CSV persistence through `tracker.py`.

By default, the application stores `Tracker.csv` in the operating system's per-user application-data directory using `platformdirs`. This avoids relying on the installation directory, which may not be writable on Windows when the application is installed under locations such as `Program Files`.

The stored fields are:

```text
ID, Category, Name, Value, Date
```

Money values are represented with `Decimal` to avoid common floating-point rounding problems.

## Testing

Run the tracker tests with:

```bash
pytest test_tracker.py
```

Run the API tests with:

```bash
python test_api.py
```

Or run the complete pytest suite:

```bash
pytest
```

## Windows build

Spendly can be packaged as a Windows executable with its wallet icon embedded in the application.

### Build the executable

Install PyInstaller if it is not already installed:

```powershell
python -m pip install pyinstaller
```

Then run the project-root command:

```powershell
pyinstaller packaging\spendly.spec
```

The generated executable is placed under the `dist` directory.

### Create the installer

The repository also includes an Inno Setup script:

```text
packaging/Spendly.iss
```

Open the script with [Inno Setup](https://jrsoftware.org/isinfo.php) and compile it to create a Windows installer with Spendly branding and shortcuts.

## Design & branding

Spendly uses a simple wallet-based visual identity designed around:

- Deep green as the primary brand color
- Mint and cream as supporting UI colors
- A wallet icon as the app mark
- The **Spendly** wordmark for the application name
- Original category colors preserved to keep categories visually distinguishable

The primary app icon assets live in `assets/`, while the Windows `.ico` file lives in `packaging/`.

## Roadmap

Potential future improvements include:

- [ ] Move from CSV to SQLite
- [ ] Add SQLAlchemy-based data access
- [ ] User accounts and authentication
- [ ] Budget tracking
- [ ] Dashboard charts and spending trends
- [ ] More advanced date-range filtering
- [ ] CSV export/import tools
- [ ] PostgreSQL support for deployed environments
- [ ] Dockerized deployment
- [ ] CI pipeline for automated tests

## Contributing

This is currently a personal project, but contributions and suggestions are welcome. If you find a bug or have an idea for an improvement, open an issue or submit a pull request.

## License

Spendly is released under the **MIT License**. See [`LICENSE`](LICENSE) for details.

---

<div align="center">
  <img src="assets/spendly-icon-64.png" alt="Spendly wallet" width="48">
  <br>
  <strong>Spendly</strong> · Track your spending. Stay in control.
</div>
