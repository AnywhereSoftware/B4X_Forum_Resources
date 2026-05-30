#!/bin/bash
#===============================================================================
# B4J Post-Install Configuration Script
# Configures b4xV5.ini with optimized settings after B4J first run
# Author: pyhoon (Aeric)
# Date: 26 May 2026
# License: MIT
#===============================================================================

set -euo pipefail

#-------------------------------------------------------------------------------
# CONFIGURATION
#-------------------------------------------------------------------------------
readonly WINE_PREFIX="${HOME}/.wine_b4j"
readonly B4J_INI_FILE="${WINE_PREFIX}/drive_c/users/$(whoami)/AppData/Roaming/Anywhere Software/B4J/b4xV5.ini"

# Colors
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

log_info()    { echo -e "${YELLOW}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_error()   { echo -e "${RED}[✗]${NC} $1" >&2; }

#-------------------------------------------------------------------------------
# INI FILE HELPER: Set or update a key=value pair
#-------------------------------------------------------------------------------
ini_set() {
    local file="$1" key="$2" value="$3"
    
    if [[ ! -f "$file" ]]; then
        log_error "INI file not found: $file"
        log_info "Please launch B4J at least once first, then run this script again."
        exit 1
    fi
    
    if grep -q "^${key}=" "$file" 2>/dev/null; then
        sed -i "s|^${key}=.*|${key}=${value}|" "$file"
    else
        echo "${key}=${value}" >> "$file"
    fi
}

#-------------------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------------------
echo -e "\n${GREEN}════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  B4J Post-Install Configuration${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════════${NC}\n"

# Check if B4J has been run (INI file exists)
if [[ ! -f "$B4J_INI_FILE" ]]; then
    log_error "b4xV5.ini not found at: ${B4J_INI_FILE}"
    echo ""
    echo -e "${YELLOW}Please do the following:${NC}"
    echo "  1. Launch B4J from your application menu or desktop"
    echo "  2. Let it fully load (you can close it immediately after)"
    echo "  3. Run this script again: ./configure_b4j_settings.sh"
    echo ""
    exit 1
fi

log_info "Configuring b4xV5.ini..."

# Apply your requested settings
ini_set "$B4J_INI_FILE" "FontName2" "Ubuntu Sans Mono"
ini_set "$B4J_INI_FILE" "FontSize2" "15"
ini_set "$B4J_INI_FILE" "logs_FontName2" "Ubuntu Sans"
ini_set "$B4J_INI_FILE" "logs_FontSize2" "15"
ini_set "$B4J_INI_FILE" "JavaBin" "C:\\\\Java\\\\jdk-19.0.2\\\\bin\\\\"
ini_set "$B4J_INI_FILE" "NewProjectDefaultFolder" "${HOME}/B4J_Projects"
ini_set "$B4J_INI_FILE" "AdditionalLibrariesFolder" "C:\Additional Libraries"

log_success "B4J configuration applied!"

# Show applied settings
echo -e "\n${YELLOW}Applied settings:${NC}"
grep -E "^(AdditionalLibrariesFolder|FontName2|FontSize2|JavaBin|logs_FontName2|logs_FontSize2|NewProjectDefaultFolder)=" "$B4J_INI_FILE" | while read -r line; do
    echo "  • $line"
done

echo -e "\n${GREEN}✨ Configuration complete! Launch B4J to enjoy your optimized settings.${NC}\n"
exit 0
