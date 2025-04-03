# 🌙 Lunar Heist Admin Menu

A clean, modern ox_lib-based admin panel for managing player **donate crypto** and **experience (XP)** using the `lunar_heistcontracts` exports.

## 📦 Features

- 🎛️ Open `/adminheist` menu to:
  - ➕ Add / ➖ Remove Crypto  
  - 📈 Add / 📉 Remove Experience  
  - 🔍 Check Player's Crypto or XP  
- 🧠 Uses `ox_lib` context menus and input dialogs  
- 🔐 Admin-only access (uses ESX group check)  
- 🛠 Full integration with `lunar_heistcontracts` exports  

---

## 🧩 Requirements

- ✅ [ox_lib](https://github.com/overextended/ox_lib)
- ✅ ESX framework (legacy or v1/v2)
- ✅ `lunar_heistcontracts` resource

---

## 🧰 Installation

1. **Place the resource** in your `resources/[admin]` folder (or any category you use).

2. **Ensure dependencies are started first** in `server.cfg`:
   ```cfg
   ensure ox_lib
   ensure es_extended
   ensure lunar_heistcontracts
   ensure LunarAdmin
   ```

3. **Make sure your `fxmanifest.lua` has**:
   ```lua
   lua54 'yes'
   dependency 'ox_lib'
   ```

4. **Restart or refresh**:
   ```
   refresh
   restart LunarAdmin
   ```

---

## 💬 Commands

| Command       | Description               | Permissions |
|---------------|---------------------------|-------------|
| `/adminheist` | Opens the player manager  | Admin-only  |

---

## 🧪 Usage

1. Type `/adminheist` in chat.  
2. Select a player from the list.  
3. Choose one of the actions (add/remove/check).  
4. Input the amount if required.  
5. All actions are confirmed with in-game notifications.  

---

## 🔐 Permissions

Only players with `admin` group in ESX (`xPlayer.getGroup()`) can use this system.

You can modify the permission check in:

```lua
if not xAdmin or xAdmin.getGroup() ~= 'admin' then return end
```

Change `"admin"` to `"superadmin"`, `"mod"`, or your custom role as needed.

---

## 🧾 Exports Used

From `lunar_heistcontracts`:
```lua
addPlayerCrypto(identifier, amount)
removePlayerCrypto(identifier, amount)
addPlayerExperience(identifier, amount)
removePlayerExperience(identifier, amount)
getPlayerCrypto(identifier)
getPlayerExperience(identifier)
```

---

## 📁 File Structure

```
LunarAdmin/
├── fxmanifest.lua
├── config.lua
├── README.md
├── client/
│   └── admin_heist_menu.lua
└── server/
    └── admin_heist_menu.lua
```
