# VSCode Profiles Sync

Cursor, VSCode, Antigravity 세 IDE의 설정을 동기화하기 위한 레포지토리입니다.

## 구조

```
vscode-profiles/
├── README.md
├── settings.json        # 공통 설정
├── keybindings.json     # 키바인딩
├── extensions.txt       # 확장 프로그램 목록
├── snippets/            # 코드 스니펫
├── install.ps1          # Windows 설치 스크립트
└── install.sh           # macOS/Linux 설치 스크립트
```

## 빠른 시작

### 1. 레포지토리 클론

```bash
git clone https://github.com/YOUR_USERNAME/vscode-profiles.git
cd vscode-profiles
```

### 2. 설치 실행

#### Windows (PowerShell)

```powershell
# 모든 IDE에 적용
.\install.ps1

# 특정 IDE만 적용
.\install.ps1 -Cursor
.\install.ps1 -VSCode
.\install.ps1 -Antigravity

# 설정만 적용 (확장 제외)
.\install.ps1 -SettingsOnly

# 확장만 설치 (설정 제외)
.\install.ps1 -ExtensionsOnly
```

#### macOS / Linux

```bash
# 실행 권한 부여
chmod +x install.sh

# 모든 IDE에 적용
./install.sh

# 특정 IDE만 적용
./install.sh --cursor
./install.sh --vscode
./install.sh --antigravity

# 설정만 적용
./install.sh --settings-only

# 확장만 설치
./install.sh --extensions-only
```

## 설정 파일 위치

### Windows

| IDE | 설정 경로 |
|-----|----------|
| Cursor | `%APPDATA%\Cursor\User\` |
| VSCode | `%APPDATA%\Code\User\` |
| Antigravity | `%APPDATA%\Antigravity\User\` |

### macOS

| IDE | 설정 경로 |
|-----|----------|
| Cursor | `~/Library/Application Support/Cursor/User/` |
| VSCode | `~/Library/Application Support/Code/User/` |
| Antigravity | `~/Library/Application Support/Antigravity/User/` |

### Linux

| IDE | 설정 경로 |
|-----|----------|
| Cursor | `~/.config/Cursor/User/` |
| VSCode | `~/.config/Code/User/` |
| Antigravity | `~/.config/Antigravity/User/` |

## 확장 프로그램

`extensions.txt` 파일에 설치할 확장 프로그램 목록이 있습니다:

- **Dart & Flutter**: dart-code.dart-code, dart-code.flutter
- **Java**: redhat.java, vscjava.vscode-java-pack 등
- **Theme**: PranjalKumar.minimal-kiwi

### 확장 추가하기

`extensions.txt`에 확장 ID를 추가하세요:

```
# 새 확장 추가
publisher.extension-name
```

확장 ID는 마켓플레이스 URL에서 확인할 수 있습니다:
`https://marketplace.visualstudio.com/items?itemName=publisher.extension-name`

## 설정 업데이트하기

### 현재 설정 내보내기 (Windows)

```powershell
# Cursor 설정을 레포로 복사
Copy-Item "$env:APPDATA\Cursor\User\settings.json" .\settings.json
Copy-Item "$env:APPDATA\Cursor\User\keybindings.json" .\keybindings.json
```

### 현재 설정 내보내기 (macOS)

```bash
# Cursor 설정을 레포로 복사
cp ~/Library/Application\ Support/Cursor/User/settings.json ./settings.json
cp ~/Library/Application\ Support/Cursor/User/keybindings.json ./keybindings.json
```

### 변경사항 푸시

```bash
git add .
git commit -m "Update settings"
git push
```

## 새 PC에서 설정하기

```bash
# 1. 레포 클론
git clone https://github.com/YOUR_USERNAME/vscode-profiles.git
cd vscode-profiles

# 2. 설치 스크립트 실행
# Windows:
powershell -ExecutionPolicy Bypass -File .\install.ps1

# macOS/Linux:
chmod +x install.sh && ./install.sh

# 3. IDE 재시작
```

## 주의사항

- `keybindings.json`의 `composerMode.agent` 명령은 Cursor 전용입니다
- 일부 확장은 플랫폼별로 다를 수 있습니다
- IDE를 재시작해야 변경사항이 적용됩니다

## 포함된 테마

- **Minimal Kiwi**: 깔끔한 미니멀 테마
  - 설정: `"workbench.colorTheme": "Minimal Kiwi"`
