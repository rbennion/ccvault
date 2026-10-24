---
type: dashboard
---

# Todos

> [!info] How this works
> Every task lives inside the project file it belongs to. This page gathers them all with live queries, so never edit it by hand. Needs the **Tasks** community plugin.
>
> Projects flagged `surface: optional` or `surface: latent` are hidden from the daily sections. Latent work shows in its own section for the weekly review.

---

## Overdue

```tasks
not done
filter by function task.file.property('surface') !== 'optional' && task.file.property('surface') !== 'latent'
due before today
sort by priority
sort by due
group by filename
hide task count
```

---

## Today

```tasks
not done
filter by function task.file.property('surface') !== 'optional' && task.file.property('surface') !== 'latent'
due on today
sort by priority
group by filename
hide task count
```

---

## Next 7 Days

```tasks
not done
filter by function task.file.property('surface') !== 'optional' && task.file.property('surface') !== 'latent'
due after today
due before in 8 days
sort by due
sort by priority
group by due
hide task count
```

---

## High Priority (no due date)

```tasks
not done
filter by function task.file.property('surface') !== 'optional' && task.file.property('surface') !== 'latent'
priority is above medium
no due date
sort by priority
group by filename
hide task count
```

---

## Everything Else (no date, no priority)

```tasks
not done
filter by function task.file.property('surface') !== 'optional' && task.file.property('surface') !== 'latent'
no due date
priority is none
group by filename
hide task count
```

---

## Latent: check weekly

> No deadline, but a real downside if it rots: backups, taxes, a will, renewals.

```tasks
not done
filter by function task.file.property('surface') === 'latent'
group by filename
hide task count
```

---

## Work Focus

```tasks
not done
filter by function task.file.property('domain') === 'work' && task.file.property('surface') !== 'optional' && task.file.property('surface') !== 'latent'
sort by priority
sort by due
group by filename
hide task count
```

---

## Personal Focus

```tasks
not done
filter by function task.file.property('domain') === 'personal' && task.file.property('surface') !== 'optional' && task.file.property('surface') !== 'latent'
sort by priority
sort by due
group by filename
hide task count
```

---

## Done in the Last 7 Days

```tasks
done after 7 days ago
sort by done reverse
group by done
hide task count
```
