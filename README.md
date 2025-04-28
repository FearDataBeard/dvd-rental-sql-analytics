# dvd-rental-sql-analytics

# 🎯 DVD Rental SQL Analytics Suite

A comprehensive, production-aware SQL reporting environment designed using the PostgreSQL **DVD Rental** sample database. This project showcases a structured approach to **data analytics, integrity, and optimization**, using industry-aligned practices such as:

- Common Table Expressions (CTEs)
- Materialized Views
- Transaction Controls (`BEGIN`, `COMMIT`, `ROLLBACK`)
- Indexing for performance
- Triggers and procedural logic

> **Platform:** pgAdmin v9.2 / PostgreSQL  
> **Focus:** Real-world analytics, governance, and performance-tuned SQL design

---

## 📊 Core Business KPIs

- Total customers, active vs inactive per store
- Top 5 revenue-generating customers
- Total revenue by store
- Customer-specific category preference insights

---

## 🧠 Advanced Logic Highlights

- **CTE Layering:** Breaks down complex logic into human-readable steps
- **Materialized View:** Pre-computed top-spending customer category usage
- **Indexing:** Designed for fast category lookup and sorting
- **Transaction Control:** Built-in rollback safety for DML testing
- **Trigger Function:** Automatically captures creation timestamps during inserts

---

## 🧱 File Breakdown

| Section                        | Purpose |
|-------------------------------|---------|
| Core Queries                  | Key business metrics from DVD schema |
| CTE + MV                      | Advanced joins & optimized reusable views |
| Indexing                      | Improves read performance on materialized view |
| Triggers                      | Adds audit field via function & hook |
| Transaction Tests             | Validates rollback/safety logic |
| Final Output                  | Displays the top category for the top customer |

---

## 🛡️ DAMA-DMBOK Aligned

All queries were designed with **data ethics and governance in mind**:
- No PII usage
- Maintains schema transparency
- Encourages audit-safe logic structure

---

## 🚀 Getting Started

To run these queries:
1. Import the [DVD Rental Database](https://www.postgresqltutorial.com/postgresql-sample-database/) into pgAdmin
2. Open `Rand_SQL_Cleaned_DVD_Rental.sql`
3. Execute blocks by section to explore reporting flow

---

## 📂 Author

**Rand Codon II**  
*Data Analyst | SQL • Power BI • Python • Data Storytelling*  
[Portfolio Website](https://your-portfolio-link.com) • [LinkedIn](https://linkedin.com/in/yourprofile) • [GitHub](https://github.com/yourusername)

---

