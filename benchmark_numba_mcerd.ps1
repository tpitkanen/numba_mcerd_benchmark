function Remove-Pycache() {
	if (Test-Path -Path __pycache__) {
		Remove-Item -Recurse -Force -Path __pycache__
	}

	if (Test-Path -Path mcerd\__pycache__) {
		Remove-Item -Recurse -Force -Path mcerd\__pycache__
	}
}


Push-Location

Set-Location c:\kurssit\gradu\koodi\numba_mcerd\
.\env\Scripts\activate

$env:PYTHONPATH = (Get-Location).Path
Set-Location numba_mcerd

python main_jit.py > out_jit_first.txt
python main_jit.py > out_jit_second.txt
python main_jit.py > out_jit_third.txt
Remove-Pycache

python main_jit_mt.py > out_jit_mt_first.txt
python main_jit_mt.py > out_jit_mt_second.txt
python main_jit_mt.py > out_jit_mt_third.txt
Remove-Pycache

# TODO: These are too big to run full size, only do 10k + 100k
# python main.py > out_vanilla_first.txt
# python main.py > out_vanilla_second.txt
# Remove-Pycache()

Pop-Location
