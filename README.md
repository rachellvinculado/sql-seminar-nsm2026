# sql-seminar-nsm2026

Materials for the SQL seminar delivered at **Visayas State University** for the **37th National Statistics Month (October 2026)**.

**Theme:** *Tuklas Pilipinas: Statistics as Beacon Towards Inclusive, Resilient, and Sustainable Tourism*

---

## 📁 Contents

| File | Description |
|------|-------------|
| `SQL_Seminar_Deck_102026.pptx` | Full 45-slide presentation deck |
| `tourism_ph.db` | SQLite database — 15 destinations, 100 tourists, 1,110 visits |
| `demo_queries.sql` | Live demo queries organized by section (A–G) |

---

## 🗄️ Database Schema

**`destinations`** (15 rows)
- Real Philippine destinations: Boracay, El Nido, Coron, Siargao, Intramuros, Vigan, Banaue Rice Terraces, Chocolate Hills, Puerto Princesa Underground River, and more
- Columns: `destination_id`, `destination_name`, `region`, `category`, `province`

**`tourists`** (100 rows)
- Nationality distribution based on DOT data (South Korean, American, Filipino, Australian, Japanese, etc.)
- Columns: `tourist_id`, `first_name`, `last_name`, `nationality`, `tourist_type`, `age_group`, `sex`

**`visits`** (1,110 rows)
- Columns: `visit_id`, `tourist_id`, `destination_id`, `visit_date`, `length_of_stay`, `purpose`, `accommodation`, `spending_php`
- ~12% of `spending_php` values are `NULL` — intentional, for the data quality lesson

---

## 🔬 Live Demo Sections

| Section | Topic |
|---------|-------|
| A | Getting to Know the Data |
| B | Who is Visiting? |
| C | Where Are They Going? |
| D | Overloading or Underserved? |
| E | How Clean Is Our Data? |
| F | What Does a Visit Look Like? |
| G | The Full Picture: 3-Table JOIN |

---

## 🛠️ How to Use

### Step 1 — Download the database

Download `tourism_ph.db` from this repository to your computer.

### Step 2 — Open SQLiteOnline

Go to [sqliteonline.com](https://sqliteonline.com) in your browser. No account or installation needed.

### Step 3 — Load the database

1. On the left panel, look for the **SQLite** section
2. Click the **folder icon** (📂) next to "0.2 beta" — this is the Open DB button
3. A file picker will appear — select `tourism_ph.db` from wherever you saved it
4. Click **Open**
5. You should now see `destinations`, `tourists`, and `visits` listed under **Table** in the left panel

### Step 4 — Run the queries

1. Download `demo_queries.sql` and open it in any text editor (Notepad, VS Code, Notepad++)
2. Copy a query from the file
3. Paste it into the editor (the large text area in the middle of the screen)
4. Click **▶ Run** in the top bar, or press `Ctrl + Enter`
5. Results will appear in the panel below the editor

> **Tip:** You can run one query at a time by selecting just that block of text before clicking Run.

---

## 👩‍💻 Presenter

**Rachell Batucan**
Senior Data Scientist, Trella Health LLC
BS Statistics 2015, Visayas State University (Magna Cum Laude)

---

## 📄 License

MIT — feel free to use and adapt for your own teaching.
