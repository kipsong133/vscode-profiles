# VSCode Profiles Sync

Cursor, VSCode, Antigravity 세 IDE의 설정을 동기화하기 위한 레포지토리입니다.

## 지원 플랫폼

- Windows 10/11
- macOS
- Linux

## 구조

```
vscode-profiles/
├── README.md            # 이 문서
├── settings.json        # 공통 설정
├── keybindings.json     # 키바인딩
├── extensions.txt       # 확장 프로그램 목록
├── snippets/            # 코드 스니펫
├── install.ps1          # Windows 설치 스크립트
└── install.sh           # macOS/Linux 설치 스크립트
```

---

## 빠른 시작

### 1. 레포지토리 클론

```bash
git clone https://github.com/kipsong133/vscode-profiles.git
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

---

## 포함된 설정 상세

### settings.json

| 설정 | 값 | 설명 |
|------|-----|------|
| `workbench.colorTheme` | `"Minimal Kiwi"` | 깔끔한 미니멀 테마 |
| `window.commandCenter` | `true` | 상단 명령 센터 활성화 |
| `redhat.telemetry.enabled` | `false` | RedHat 텔레메트리 비활성화 |
| `explorer.confirmDragAndDrop` | `false` | 드래그앤드롭 확인 비활성화 |
| `explorer.confirmDelete` | `false` | 삭제 확인 비활성화 |
| `terminal.external.windowsExec` | `WezTerm` | 외부 터미널로 WezTerm 사용 |
| `editor.accessibilitySupport` | `"off"` | 접근성 지원 비활성화 |

#### 접근성 사운드 설정 (모두 비활성화)
- 에러/경고/폴드/브레이크포인트 라인 알림음
- 터미널 벨/명령 실패 알림음
- 작업 완료/실패 알림음

#### Dart 언어 설정
| 설정 | 값 | 설명 |
|------|-----|------|
| `editor.formatOnSave` | `true` | 저장 시 자동 포맷 |
| `editor.formatOnType` | `true` | 타이핑 시 자동 포맷 |
| `editor.rulers` | `[80]` | 80자 가이드라인 표시 |
| `editor.tabCompletion` | `"onlySnippets"` | 탭 완성은 스니펫만 |
| `editor.wordBasedSuggestions` | `"off"` | 단어 기반 제안 비활성화 |

### keybindings.json

| 단축키 | 명령 | 설명 |
|--------|------|------|
| `Ctrl+I` | `composerMode.agent` | Cursor AI 에이전트 모드 (Cursor 전용) |
| `Shift+Enter` | Terminal Send Sequence | 터미널에서 ESC+Enter 전송 |

---

## 확장 프로그램 목록

### Remote Development
| 확장 | ID | 설명 |
|------|-----|------|
| WSL | `ms-vscode-remote.remote-wsl` | Windows Subsystem for Linux 지원 |

### Dart & Flutter
| 확장 | ID | 설명 |
|------|-----|------|
| Dart | `dart-code.dart-code` | Dart 언어 지원 |
| Flutter | `dart-code.flutter` | Flutter 프레임워크 지원 |
| Flutter Riverpod Snippets | `robert-brunhage.flutter-riverpod-snippets` | Riverpod 코드 스니펫 |

### Java Development
| 확장 | ID | 설명 |
|------|-----|------|
| Language Support for Java | `redhat.java` | Java 언어 지원 |
| Java Extension Pack | `vscjava.vscode-java-pack` | Java 확장 통합 팩 |
| Debugger for Java | `vscjava.vscode-java-debug` | Java 디버거 |
| Java Test Runner | `vscjava.vscode-java-test` | Java 테스트 실행 |
| Maven for Java | `vscjava.vscode-maven` | Maven 빌드 도구 |
| Gradle for Java | `vscjava.vscode-gradle` | Gradle 빌드 도구 |
| Project Manager for Java | `vscjava.vscode-java-dependency` | Java 프로젝트 관리 |

### Theme
| 확장 | ID | 설명 |
|------|-----|------|
| Minimal Kiwi | `PranjalKumar.minimal-kiwi` | 깔끔한 미니멀 컬러 테마 |

---

## 설정 파일 위치

### Windows

| IDE | 설정 경로 | 확장 경로 |
|-----|----------|----------|
| Cursor | `%APPDATA%\Cursor\User\` | `%USERPROFILE%\.cursor\extensions\` |
| VSCode | `%APPDATA%\Code\User\` | `%USERPROFILE%\.vscode\extensions\` |
| Antigravity | `%APPDATA%\Antigravity\User\` | `%USERPROFILE%\.antigravity\extensions\` |

### macOS

| IDE | 설정 경로 | 확장 경로 |
|-----|----------|----------|
| Cursor | `~/Library/Application Support/Cursor/User/` | `~/.cursor/extensions/` |
| VSCode | `~/Library/Application Support/Code/User/` | `~/.vscode/extensions/` |
| Antigravity | `~/Library/Application Support/Antigravity/User/` | `~/.antigravity/extensions/` |

### Linux

| IDE | 설정 경로 | 확장 경로 |
|-----|----------|----------|
| Cursor | `~/.config/Cursor/User/` | `~/.cursor/extensions/` |
| VSCode | `~/.config/Code/User/` | `~/.vscode/extensions/` |
| Antigravity | `~/.config/Antigravity/User/` | `~/.antigravity/extensions/` |

---

## 설정 업데이트하기

### 현재 설정 내보내기 (Windows)

```powershell
cd vscode-profiles

# Cursor 설정을 레포로 복사
Copy-Item "$env:APPDATA\Cursor\User\settings.json" .\settings.json
Copy-Item "$env:APPDATA\Cursor\User\keybindings.json" .\keybindings.json

# 스니펫 복사 (있는 경우)
Copy-Item "$env:APPDATA\Cursor\User\snippets\*" .\snippets\ -Recurse
```

### 현재 설정 내보내기 (macOS)

```bash
cd vscode-profiles

# Cursor 설정을 레포로 복사
cp ~/Library/Application\ Support/Cursor/User/settings.json ./settings.json
cp ~/Library/Application\ Support/Cursor/User/keybindings.json ./keybindings.json

# 스니펫 복사 (있는 경우)
cp -r ~/Library/Application\ Support/Cursor/User/snippets/* ./snippets/
```

### 변경사항 푸시

```bash
git add .
git commit -m "Update settings"
git push
```

---

## 새 PC에서 설정하기

### Windows

```powershell
# 1. Git이 없다면 설치
winget install --id Git.Git -e

# 2. 레포 클론
git clone https://github.com/kipsong133/vscode-profiles.git
cd vscode-profiles

# 3. 설치 스크립트 실행
powershell -ExecutionPolicy Bypass -File .\install.ps1

# 4. IDE 재시작
```

### macOS

```bash
# 1. Git이 없다면 설치 (Xcode Command Line Tools)
xcode-select --install

# 2. 레포 클론
git clone https://github.com/kipsong133/vscode-profiles.git
cd vscode-profiles

# 3. 설치 스크립트 실행
chmod +x install.sh
./install.sh

# 4. IDE 재시작
```

### Linux

```bash
# 1. Git 설치 (Ubuntu/Debian)
sudo apt install git

# 2. 레포 클론
git clone https://github.com/kipsong133/vscode-profiles.git
cd vscode-profiles

# 3. 설치 스크립트 실행
chmod +x install.sh
./install.sh

# 4. IDE 재시작
```

---

## 확장 프로그램 추가하기

### 1. 마켓플레이스에서 확장 ID 확인

마켓플레이스 URL에서 확장 ID를 확인합니다:
```
https://marketplace.visualstudio.com/items?itemName=publisher.extension-name
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^
                                                      이 부분이 확장 ID
```

### 2. extensions.txt에 추가

```bash
# extensions.txt 파일 편집
echo "publisher.extension-name" >> extensions.txt
```

### 3. 커밋 및 푸시

```bash
git add extensions.txt
git commit -m "Add extension: publisher.extension-name"
git push
```

---

## 주의사항

- `keybindings.json`의 `composerMode.agent` 명령은 **Cursor 전용**입니다 (VSCode/Antigravity에서는 무시됨)
- `terminal.external.windowsExec`의 WezTerm 경로는 Windows 전용입니다
- 일부 확장은 플랫폼별로 다를 수 있습니다
- IDE를 재시작해야 변경사항이 적용됩니다
- 설정 충돌 시 기존 설정이 덮어씌워집니다 (백업 권장)

---

## 트러블슈팅

### Windows에서 스크립트 실행 오류

```powershell
# 실행 정책 일시적으로 변경
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
.\install.ps1
```

### macOS/Linux에서 권한 오류

```bash
chmod +x install.sh
./install.sh
```

### 확장 설치 실패

CLI가 PATH에 없을 수 있습니다. 수동으로 설치:

```bash
# VSCode
code --install-extension publisher.extension-name

# Cursor
cursor --install-extension publisher.extension-name

# Antigravity
antigravity --install-extension publisher.extension-name
```

---

## 라이선스

MIT License
