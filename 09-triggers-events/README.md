### Triggers and Events

A Trigger is a PL/SQL block that **automatically** executes when a specific event occurs in the database.

```bash
Event Occurs
      ↓
Trigger Fires Automatically
      ↓
PL/SQL Code Executes
```

#### What is an Event?

An event is an action that causes a trigger to fire. Common events:

| Event Type      | Examples                         |
| --------------- | -------------------------------- |
| DML Events      | INSERT, UPDATE, DELETE           |
| DDL Events      | CREATE, ALTER, DROP              |
| Database Events | LOGON, LOGOFF, STARTUP, SHUTDOWN |
