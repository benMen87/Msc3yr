import argparse

def csv2latex(csvfile):
	with open(csvfile, 'r') as csv:
		table = csv.read().replace(","," & ")
		table = table.replace("\n"," \\\ \n \hline \n")
	with open('textable.tex', 'w') as textable:
		textable.write(table)
		
		
if __name__ == '__main__':
	parser = argparse.ArgumentParser(description='Converte csv format to latex')
	parser.add_argument('-f', '--csv_fullpath')
	args = parser.parse_args()
	csv2latex(args.csv_fullpath)