make:
	mix escript.build
clean:
	rm -f compiladorwombat ejemplo/*.out \
	test/stage_1/invalid/*.out \
	test/stage_1/valid/*.out
