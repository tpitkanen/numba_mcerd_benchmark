# Copy-pasted from benchmark_numba_mcerd.ps1
function Remove-Pycache() {
	if (Test-Path -Path __pycache__) {
		Remove-Item -Recurse -Force -Path __pycache__
	}

	if (Test-Path -Path mcerd\__pycache__) {
		Remove-Item -Recurse -Force -Path mcerd\__pycache__
	}
}

Set-Location c:\kurssit\gradu\koodi\
git clone git@github.com:tpitkanen/numba_mcerd.git
Set-Location numba_mcerd

py -3.8 -m venv env
.\env\Scripts\activate
pip install -r requirements.txt

# Warm-up once to make sure the Virtualenv's Python and modules are compiled
python main_jit.py
Remove-Pycache
