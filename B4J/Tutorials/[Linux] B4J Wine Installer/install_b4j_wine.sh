#!/bin/bash
#===============================================================================
# B4J Silent Installer for Linux Mint (Wine-based)
# Installs: Wine, Winetricks, B4J, JDK19, .NET Framework, VC++ Runtime and configures everything for a smooth B4J experience on Linux Mint.
# Author: pyhoon (Aeric)
# AI Assistant: Qwen3.6 Plus
# Date: 25 May 2026
# License: MIT
#===============================================================================

set -e  # Exit on error

#-------------------------------------------------------------------------------
# CONFIGURATION (UPDATED FOR 64-BIT)
#-------------------------------------------------------------------------------
readonly SCRIPT_NAME="$(basename "$0")"
readonly B4J_URL="https://www.b4x.com/b4j/files/B4J.exe"
readonly JDK_URL="https://www.b4x.com/b4j/files/jdk-19.0.2.zip"
readonly WINE_PREFIX="${HOME}/.wine_b4j"
readonly WINE_ARCH="win64"  # ✅ CHANGED: 64-bit required for B4J.exe
readonly JAVA_WINE_PATH="C:\\Java"
readonly DESKTOP_ENTRY="${HOME}/.local/share/applications/b4j-wine.desktop"
readonly ICON_URL="https://raw.githubusercontent.com/pyhoon/b4j-wine-installer/refs/heads/main/icons/B4J.png"

# Colors for terminal output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

#-------------------------------------------------------------------------------
# HELPER FUNCTIONS
#-------------------------------------------------------------------------------
log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
log_error()   { echo -e "${RED}[✗]${NC} $1" >&2; }

check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "Do not run this script as root. Use sudo only when prompted."
        exit 1
    fi
}

check_mint() {
    if ! grep -qi "linux mint" /etc/os-release 2>/dev/null; then
        log_warn "This script is optimized for Linux Mint. Proceeding anyway..."
    fi
}

get_ubuntu_codename() {
    # Linux Mint is based on Ubuntu; WineHQ uses Ubuntu codenames
    local codename
    codename=$(grep '^UBUNTU_CODENAME=' /etc/os-release | cut -d= -f2)
    case "$codename" in
        noble|jammy) echo "$codename" ;;
        *) log_error "Unsupported Ubuntu base: $codename (Mint 21.x=jammy, 22.x=noble)"; exit 1 ;;
    esac
}

download_file() {
    local url="$1" dest="$2"
    if command -v wget &>/dev/null; then
        wget -q --show-progress -O "$dest" "$url"
    elif command -v curl &>/dev/null; then
        curl -fSL -o "$dest" "$url"
    else
        log_error "Neither wget nor curl found. Please install one."
        exit 1
    fi
}

#-------------------------------------------------------------------------------
# MAIN INSTALLATION STEPS
#-------------------------------------------------------------------------------

echo -e "\n${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  B4J Silent Installer for Linux Mint (Wine-based)      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}\n"

check_root
check_mint

#-------------------------------------------------------------------------------
# 1. Update system & install prerequisites
#-------------------------------------------------------------------------------
#log_info "Updating system packages..."
#sudo apt update -qq
#sudo apt upgrade -y -qq

#log_info "Installing prerequisites for WineHQ repository..."
#sudo apt install -y ca-certificates curl gnupg software-properties-common apt-transport-https

#-------------------------------------------------------------------------------
# 2. Enable 32-bit architecture (required for many Windows apps)
#-------------------------------------------------------------------------------
log_info "Enabling 32-bit architecture support..."
sudo dpkg --add-architecture i386 2>/dev/null || true

#-------------------------------------------------------------------------------
# 3. Add WineHQ repository & GPG key (with conflict handling)
#-------------------------------------------------------------------------------
log_info "Cleaning up any conflicting WineHQ repository configurations..."

# Remove old/conflicting WineHQ source files (both legacy .list and new .sources formats)
sudo rm -f /etc/apt/sources.list.d/winehq*.sources 2>/dev/null || true
sudo rm -f /etc/apt/sources.list.d/winehq*.list 2>/dev/null || true
sudo rm -f /etc/apt/sources.list.d/winehq*.list.save 2>/dev/null || true

# Remove conflicting keyring files
sudo rm -f /usr/share/keyrings/winehq*.gpg 2>/dev/null || true
sudo rm -f /etc/apt/keyrings/winehq*.key 2>/dev/null || true

# Clean APT lists to avoid cached errors
sudo apt clean -qq 2>/dev/null || true

log_info "Adding fresh WineHQ repository..."
CODENAME=$(get_ubuntu_codename)

# Create keyring directory and import GPG key (DEB822 format)
sudo install -m 0755 -d /usr/share/keyrings
curl -fsSL https://dl.winehq.org/wine-builds/winehq.key | \
    sudo gpg --dearmor --yes -o /usr/share/keyrings/winehq.gpg

# Add DEB822 format repository file (modern standard)
sudo tee /etc/apt/sources.list.d/winehq.sources > /dev/null <<EOF
Types: deb
URIs: https://dl.winehq.org/wine-builds/ubuntu/
Suites: ${CODENAME}
Components: main
Signed-By: /usr/share/keyrings/winehq.gpg
EOF

sudo apt update -qq

#-------------------------------------------------------------------------------
# 4. Install Wine Stable (recommended for production)
#-------------------------------------------------------------------------------
log_info "Installing Wine Stable (latest)..."
sudo apt install -y --install-recommends winehq-stable

# Verify installation
WINE_VERSION=$(wine --version 2>/dev/null || echo "unknown")
log_success "Wine installed: ${WINE_VERSION}"

#-------------------------------------------------------------------------------
# 5. Install Winetricks
#-------------------------------------------------------------------------------
log_info "Installing Winetricks..."
sudo apt install -y winetricks

#-------------------------------------------------------------------------------
# 6. Create dedicated Wine prefix for B4J (64-bit)
#-------------------------------------------------------------------------------
log_info "Creating dedicated 64-bit Wine prefix for B4J: ${WINE_PREFIX}"
export WINEARCH="${WINE_ARCH}"
export WINEPREFIX="${WINE_PREFIX}"

# Initialize prefix (this triggers Mono/Gecko prompts - we'll install manually)
wineboot -u 2>/dev/null || true

#-------------------------------------------------------------------------------
# 7. Install Wine Mono & Gecko manually (avoid interactive prompts)
#-------------------------------------------------------------------------------
#log_info "Installing Wine Mono and Gecko runtimes..." aeric: skipped, these can cause issues with .NET apps and B4J works better without them. If needed, users can install them manually via winetricks or by downloading the MSI files from WineHQ and installing with 'wine msiexec /i <file.msi> /qn'.
#MONO_MSI="${WINE_PREFIX}/drive_c/temp/wine-mono.msi"
#GECKO_X86="${WINE_PREFIX}/drive_c/temp/wine-gecko-x86.msi"
#GECKO_X64="${WINE_PREFIX}/drive_c/temp/wine-gecko-x64.msi"

#mkdir -p "$(dirname "$MONO_MSI")"

# Download and install Mono
#download_file "https://dl.winehq.org/wine/wine-mono/11.0.0/wine-mono-11.0.0-x86.msi" "$MONO_MSI"
#wine msiexec /i "$MONO_MSI" /qn 2>/dev/null || true

# Download and install Gecko (both architectures)
#download_file "https://dl.winehq.org/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86.msi" "$GECKO_X86"
#download_file "https://dl.winehq.org/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86_64.msi" "$GECKO_X64"
#wine msiexec /i "$GECKO_X86" /qn 2>/dev/null || true
#wine msiexec /i "$GECKO_X64" /qn 2>/dev/null || true

# Cleanup temp files
#rm -f "$MONO_MSI" "$GECKO_X86" "$GECKO_X64"

#-------------------------------------------------------------------------------
# 8. Install required Windows components via Winetricks
#-------------------------------------------------------------------------------
log_info "Installing VC++ 2010 Runtime via Winetricks..."
winetricks -q vcrun2010 2>/dev/null || {
    log_warn "Failed to install VC++ 2010 Runtime. B4J may still work, but some features could be affected."
}

log_info "Installing .NET Framework 4.5.2 via Winetricks..."
winetricks -q dotnet452 2>/dev/null || {
    log_warn "Failed to install .NET Framework 4.5.2. B4J may still work, but some features could be affected."
}

log_info "Installing DXVK (DirectX 11/12 support) via Winetricks..."
winetricks -q dxvk 2>/dev/null || {
    log_warn "Failed to install DXVK. JavaFX graphics performance may be reduced, but B4J should still function."
}

log_info "Setting GDI renderer to 'gdi' for better compatibility with B4J..."
winetricks -q renderer=gdi 2>/dev/null || {
    log_warn "Failed to set GDI renderer. If you experience graphical issues, try running 'winetricks renderer=gdi' manually in the prefix."
}

#-------------------------------------------------------------------------------
# 9. Configure Windows version to Windows 10 (recommended for .NET apps)
#-------------------------------------------------------------------------------
log_info "Setting Windows version to Windows 10..."
winecfg -v win10 2>/dev/null || true

#-------------------------------------------------------------------------------
# 10. Download and install B4J
#-------------------------------------------------------------------------------
log_info "Downloading B4J installer..."
B4J_INSTALLER="${WINE_PREFIX}/drive_c/temp/B4J.exe"
mkdir -p "$(dirname "$B4J_INSTALLER")"
download_file "${B4J_URL}" "$B4J_INSTALLER"

log_info "Installing B4J silently..."
# B4J installer supports /SILENT or /VERYSILENT (Inno Setup)
wine "$B4J_INSTALLER" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART 2>/dev/null || {
    log_warn "Silent install failed, trying interactive mode..."
    wine "$B4J_INSTALLER" 2>/dev/null || log_error "B4J installation failed"
}

#-------------------------------------------------------------------------------
# 11. Download and extract JDK19 to C:\Java in Wine prefix
#-------------------------------------------------------------------------------
log_info "Downloading JDK19..."
JDK_ZIP="${WINE_PREFIX}/drive_c/temp/jdk-19.0.2.zip"
mkdir -p "$(dirname "$JDK_ZIP")"
download_file "${JDK_URL}" "$JDK_ZIP"

log_info "Extracting JDK19 to ${JAVA_WINE_PATH}..."
# Create target directory in Wine C: drive
wine cmd /c "mkdir ${JAVA_WINE_PATH//\\//}" 2>/dev/null || mkdir -p "${WINE_PREFIX}/drive_c/Java"

# Extract using unzip (Linux native, then copy to Wine prefix)
JDK_EXTRACT_DIR="${WINE_PREFIX}/drive_c/temp/jdk_extract"
mkdir -p "$JDK_EXTRACT_DIR"
unzip -q "$JDK_ZIP" -d "$JDK_EXTRACT_DIR"

# Move extracted JDK to C:\Java
JDK_SRC=$(find "$JDK_EXTRACT_DIR" -maxdepth 1 -type d -name "jdk*" | head -1)
if [[ -n "$JDK_SRC" && -d "$JDK_SRC" ]]; then
    cp -r "$JDK_SRC"/* "${WINE_PREFIX}/drive_c/Java/" 2>/dev/null || true
    log_success "JDK19 extracted to ${JAVA_WINE_PATH}"
else
    log_warn "Could not locate JDK folder in archive"
fi

# Cleanup
rm -rf "$JDK_EXTRACT_DIR" "$JDK_ZIP"

#-------------------------------------------------------------------------------
# 12. Create desktop shortcut/launcher for B4J
#-------------------------------------------------------------------------------
log_info "Creating desktop launcher for B4J..."

# Find B4J executable (common install locations)
B4J_EXE="${WINE_PREFIX}/drive_c/Program Files/Anywhere Software/B4J/B4J.exe"
[[ ! -f "$B4J_EXE" ]] && B4J_EXE="${WINE_PREFIX}/drive_c/Program Files (x86)/Anywhere Software/B4J/B4J.exe"
[[ ! -f "$B4J_EXE" ]] && B4J_EXE="${WINE_PREFIX}/drive_c/users/$(whoami)/AppData/Local/Programs/B4J/B4J.exe"

if [[ -f "$B4J_EXE" ]]; then
    # Download icon (optional)
    ICON_PATH="${WINE_PREFIX}/drive_c/temp/b4j_icon.png"
    mkdir -p "$(dirname "$ICON_PATH")"
    download_file "${ICON_URL}" "$ICON_PATH" 2>/dev/null || ICON_PATH=""
    
    # Convert to local path for .desktop file
    LOCAL_ICON="${HOME}/.local/share/icons/b4j.png"
    mkdir -p "$(dirname "$LOCAL_ICON")"
    if [[ -n "$ICON_PATH" && -f "$ICON_PATH" ]]; then
        cp "$ICON_PATH" "$LOCAL_ICON" 2>/dev/null || true
    fi
    
    # Create .desktop file
    mkdir -p "$(dirname "$DESKTOP_ENTRY")"
    cat > "$DESKTOP_ENTRY" <<EOF
[Desktop Entry]
Version=1.0
Name=B4J
Comment=B4J IDE - Run via Wine
Exec=env WINEPREFIX="${WINE_PREFIX}" wine "${B4J_EXE}"
Path=${WINE_PREFIX}/drive_c/Program Files/Anywhere Software/B4J
Icon=${LOCAL_ICON}
Terminal=false
Type=Application
Categories=Development;IDE;
Keywords=B4J;B4X;Java;IDE;Basic;
StartupNotify=true
EOF
    
    # Make executable and update desktop database
    chmod +x "$DESKTOP_ENTRY"
    update-desktop-database "${HOME}/.local/share/applications" 2>/dev/null || true
    
    # Also copy to Desktop for convenience
    cp "$DESKTOP_ENTRY" "${HOME}/Desktop/" 2>/dev/null && \
        chmod +x "${HOME}/Desktop/b4j-wine.desktop" 2>/dev/null || true
    
    log_success "Desktop launcher created: ${DESKTOP_ENTRY}"
else
    log_warn "B4J.exe not found at expected locations. Launcher creation skipped."
fi

#-------------------------------------------------------------------------------
# 13. Create optional folders: Additional Libraries & Projects
#-------------------------------------------------------------------------------
log_info "Creating optional folder structure..."

# Create "Additional Libraries" folder in ~/.wine_b4j/drive_c with B4X subfolders
ADDITIONAL_LIBS_DIR="${WINE_PREFIX}/drive_c/Additional Libraries"
mkdir -p "${ADDITIONAL_LIBS_DIR}/B4J" "${ADDITIONAL_LIBS_DIR}/B4X"
log_success "Created C:\\Additional Libraries\\{B4J,B4X}"

# Create "Projects" folder in user's home directory
PROJECTS_DIR="${HOME}/B4J_Projects"
mkdir -p "$PROJECTS_DIR"
log_success "Created Projects folder: ${PROJECTS_DIR}"

#-------------------------------------------------------------------------------
# 14. Set permissions on Wine prefix and folders
#-------------------------------------------------------------------------------
log_info "Setting appropriate permissions..."
chmod -R u+rwX "${WINE_PREFIX}" 2>/dev/null || true
chmod 755 "$PROJECTS_DIR" 2>/dev/null || true

#-------------------------------------------------------------------------------
# 15. Final configuration tips & messages
#-------------------------------------------------------------------------------
echo -e "\n${GREEN}════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  ✓ B4J Installation Complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════════${NC}\n"

echo -e "${YELLOW}📋 Quick Start:${NC}"
echo "  1. Launch B4J from your application menu or desktop"
echo "     Or run manually: WINEPREFIX=\"${WINE_PREFIX}\" wine \"${B4J_EXE}\""
echo "  2. Let it fully initialize (creates b4xV5.ini config file)"
echo "  3. (Optional) Run post-install configuration:"
echo "     ./configure_b4j_settings.sh"
echo "  4. Start coding! 🚀"
echo ""
echo -e "${YELLOW}⚙️  Important Paths:${NC}"
echo "  • Java Compiler: ${JAVA_WINE_PATH}\\jdk-19.0.2\\bin\\javac.exe"
echo "  • Additional Libraries: C:\\Additional Libraries\\{B4J,B4X}"
echo "  • B4J Projects Folder: ${PROJECTS_DIR}"
echo ""
echo -e "${YELLOW}📁 Available Scripts:${NC}"
echo "  • Installer: ./install_b4j_wine.sh"
echo "  • Uninstaller: ./uninstall_b4j_wine.sh"
echo "  • Configurator: ./configure_b4j_settings.sh ← Run after first B4J launch"
echo ""
echo -e "${YELLOW}🔧 Troubleshooting Tips:${NC}"
echo "  • .NET errors: Ensure dotnet452 installed: winetricks list-installed"
echo "  • If B4J crashes: Try running 'winetricks gdiplus' in the prefix"
echo "  • Font issues: Try running 'winetricks corefonts fontsmooth=rgb'"
echo "  • Reset everything? ./uninstall_b4j_wine.sh --force && ./install_b4j_wine.sh"
echo ""
echo -e "${YELLOW}📚 Resources:${NC}"
echo "  • B4J Documentation: https://www.b4x.com/b4j/documentation.html"
echo "  • Wine AppDB (B4J): https://appdb.winehq.org/objectManager.php?sClass=application&iId=21338"
echo "  • B4X Forum: https://www.b4x.com/android/forum/pages/results/?query=wine"
echo ""
echo -e "${GREEN}Happy coding with B4J on Linux Mint! 🚀${NC}\n"

exit 0