/* AAlener Register-Stack-Simulator
 AArReSt */
var app = angular.module('ajaxApp', []);
app.controller('Controller', function($scope, $http) {
    var c = this;
			c.tf = "0.002"
			   c.pos = {stack: {x: 450}, call: {x: 700}, ram:{x: 100}, alu:{x: 350, y: 600}, out:{x: 200, y: 160}};
			   c.prog = [
						 ["loadc",1],
						 ["loadc",2],
						 ["loadc",3],
						 ["mult"],
						 ["add"],
						 ["write"]
						 ]

			   ;
			   
			   c.reset = function() {
			   c.pc = 0;
			   c.stack = [];
			   c.call = [];
			   c.ram = [];
			   for (var i = 0; i < 32; i++)
			   c.ram.push(0);
			   c.out=[];
			   c.adr = 0;
			   c.running = false;
			   
			   }
			   
			   c.reset();
			   c.modal_is_open = "modal_close";
			   c.progtext = JSON.stringify(c.prog);
			   //c.anim3 = angular.element(a2b);
    c.proc = function() {
			   c.running = true;
			   console.log(c.running);
			if (c.pc < 0 ||Â c.pc >= c.prog.length)
			   return; // Ausserhalb Programm
			var cmd = c.prog[c.pc][0], arg = c.prog[c.pc][1];
			   if (cmd== "loadc") {
			   var t = c.start_a1({txt:arg, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)})
			   //alert("laodc");
			   window.setTimeout(function(){c.stack.push(arg);c.pc++;c.goahead();}, t*1000);
			   }
			   else if (["add","sub","mult","div","mod", "cmpeq", "a_cmpne", "cmple", "cmplt", "cmpgt", "cmpge"].indexOf(cmd) >= 0) {
				   var re = c.stack.pop(), li = c.stack.pop(), erg;
				if (cmd == "add") erg = li + re;
				else if (cmd == "mult") erg = li * re;
				else if (cmd == "sub") erg = li - re;
			   else if (cmd == "div") erg = ~~(li / re);
			   else if (cmd == "mod") erg = li % re;
			   else if (cmd == "cmpeq") erg = (li == re) ? 1 : 0;
			   else if (cmd == "cmpne") erg = (li != re) ? 1 : 0;
			   else if (cmd == "cmple") erg = (li <= re) ? 1 : 0;
			   else if (cmd == "cmplt") erg = (li < re) ? 1 : 0;
			   else if (cmd == "cmpgt") erg = (li > re) ? 1 : 0;
			   else if (cmd == "cmpge") erg = (li >= re) ? 1 : 0;
				 var t = c.start_a2({txt: li, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y},
				   {txt: erg, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)});
			   c.start_a1({txt: re, x1: c.pos.stack.x, y1: c.y(c.stack.length+1), x2: c.pos.alu.x, y2: c.pos.alu.y});
				   window.setTimeout(function(){c.stack.push(erg) ;c.pc++;c.goahead();}, t*1000);
			   }
			   else if (cmd == "chs") {
			   var re = c.stack.pop(), erg = -re;
			   var t = c.start_a2({txt: re, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y},
					{txt: erg, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)});
			   window.setTimeout(function(){c.stack.push(erg) ;c.pc++;$scope.$apply();c.goahead();}, t * 1000);
			   }
			   else if (cmd == "write") {
			   var dummy = c.stack.pop();
			   var t = c.start_a2({txt: dummy, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y},
					{txt: dummy, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.out.x, y2: c.pos.out.y + 20*c.out.length});
			   window.setTimeout(function(){c.out.push(dummy);c.pc++;$scope.$apply();c.goahead();}, t * 1000);
			   }
			   else if (cmd == "read") {
			   var erg = parseInt(prompt('Eingabe:', ''));
			   var t = c.start_a1({txt: erg, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)});
			   window.setTimeout(function(){c.stack.push(erg) ;c.pc++;$scope.$apply();c.goahead();}, t * 1000);
			   }
			   else if (cmd == "storer") {
			   var dummy =  c.stack.pop();
			   c.adr = arg;
			   var t = c.start_a2({txt: dummy, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y},
					{txt: dummy, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.ram.x, y2: c.y(arg)});
			   window.setTimeout(function(){c.ram[arg] = dummy ;c.pc++;$scope.$apply();c.goahead();}, t*1000);
			   }
			   else if (cmd == "loadr") {
			   c.adr = arg;
			   var t = c.start_a2({txt: c.ram[arg], x1: c.pos.ram.x, y1: c.y(arg), x2: c.pos.alu.x, y2: c.pos.alu.y},
				   {txt: c.ram[arg], x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)});
			   window.setTimeout(function(){c.stack.push(c.ram[arg]) ;c.pc++;$scope.$apply();c.goahead();}, t*1000);
			   }
			   else if (cmd == "jumpz" ||Â cmd == "jumpnz") {
			   var dummy = c.stack.pop();
			   var t = c.start_a1({txt:dummy, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y});
			   window.setTimeout(function(){
					if ((dummy == 0 && cmd == "jumpz") || (dummy != 0 && cmd == "jumpnz")) c.pc = arg;
					else c.pc++;
					$scope.$apply();
								 c.goahead();
			 }, t*1000);

			   }
			   else if (cmd == "jump") {
			   var t = c.start_a1({txt:arg, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.alu.x-100, y2: c.pos.alu.y-20});
			   window.setTimeout(function(){c.pc = arg;
								 $scope.$apply();c.goahead();
								 }, t*1000);
			   }
			   else if (cmd == "nop" ) {
			   c.pc++; c.goahead();
			   }
			   else if (cmd == "call") {
			   var t = c.start_a1({txt:c.pc, x1: c.pos.alu.x-100, y1: c.pos.alu.y-20, x2: c.pos.call.x, y2: c.y(c.call.length)});
			   window.setTimeout(function(){c.call.push(c.pc);$scope.$apply();
					var t = c.start_a1({txt:arg, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.alu.x-100, y2: c.pos.alu.y-20});
								$scope.$apply();
								 window.setTimeout(function(){c.pc = arg;
									$scope.$apply();c.goahead();
								}, t*1000);
				 }, t * 1000);
			   }
			   else if (cmd == "return" ){
			   var dummy = c.call.pop();
			   var t = c.start_a1({txt:dummy, x1: c.pos.call.x, y1: c.y(c.call.length), x2: c.pos.alu.x-100, y2: c.pos.alu.y-20});
			   window.setTimeout(function(){c.pc = dummy + 1;$scope.$apply();c.goahead();
								 }, t*1000);
			   }
						else if (cmd == "loads") {
				   var adr = c.stack.pop();
			   var t = c.start_a1({txt: adr, x1: c.pos.stack.x, y1: c.y(c.stack.length+1), x2: c.pos.alu.x - 100, y2: c.pos.alu.y + 40});
			   window.setTimeout(function(){
					c.adr = adr
				   var t = c.start_a2({txt: c.ram[adr], x1: c.pos.ram.x, y1: c.y(adr), x2: c.pos.alu.x, y2: c.pos.alu.y},
				   {txt: c.ram[adr], x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)});
								 $scope.$apply();
				   window.setTimeout(function(){c.stack.push(c.ram[adr]);c.pc++;$scope.$apply();c.goahead();}, t * 1000);
								 }, t * 1000);
			   }
			   else if (cmd == "stores"){
				   var adr = c.stack.pop();
			   var t = c.start_a1({txt: adr, x1: c.pos.stack.x, y1: c.y(c.stack.length+1), x2: c.pos.alu.x - 100, y2: c.pos.alu.y + 40});
				   window.setTimeout(function(){
									 var val = c.stack.pop();
									 c.adr = adr
									 var t = c.start_a2({txt: val, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y},
										{txt: val, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.ram.x, y2: c.y(adr)});
									 c.stack.push(4712);
									 window.setTimeout(
										function(){c.stack.push(4711);c.pc++;c.goahead();alert("done");}, t * 1000);
									 }, t * 1000 +100);
			   }
			   else if (cmd == "dup") {
			   var val = c.stack.pop();
			   var t = c.start_a2(
					{txt:val, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y},
					{txt:val, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)}
								  );
			   window.setTimeout(function(){
								 c.stack.push(val);
								 $scope.$apply();
								var t = c.start_a1({txt:val, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)});
								 $scope.$apply();
								 window.setTimeout(function(){c.stack.push(val);c.pc++;c.goahead();
												   }, t*1000);

								 }, t * 1000);
			   }
			   else if (cmd == "drop") {
			   var val = c.stack.pop();
			   var t = c.start_a1(
								  {txt:val, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y}
								  );
								 window.setTimeout(function(){c.pc++;c.goahead();
												   }, t*1000);
			   }
			   else if (cmd == "swap") {
			   var re = c.stack.pop(), li = c.stack.pop();
			   var t = c.start_a2({txt: li, x1: c.pos.stack.x, y1: c.y(c.stack.length), x2: c.pos.alu.x, y2: c.pos.alu.y},
								  {txt: re, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)});
			   c.start_a1({txt: re, x1: c.pos.stack.x, y1: c.y(c.stack.length+1), x2: c.pos.alu.x, y2: c.pos.alu.y});
			   window.setTimeout(function(){
								 c.stack.push(re) ;
								$scope.$apply();
						var t = c.start_a1({txt: li, x1: c.pos.alu.x, y1: c.pos.alu.y, x2: c.pos.stack.x, y2: c.y(c.stack.length)});
								 $scope.$apply();
								 window.setTimeout(function(){c.stack.push(li) ;c.pc++;c.goahead();}, t*1000);
								 }, t*1000);
			   }

						else alert(cmd + " not implemented!!!!");
			   }; //     c.proc = function() {
						
			   c.y = function(n) {
			   		return -20*n+660;
			   }
			   
			   c.start_a1 = function(arg) {
			   var t;
			   if (arg.dur == undefined)
				   arg.dur = Math.sqrt(Math.pow(arg.x2 - arg.x1,2) + Math.pow(arg.y2 - arg.y1,2))*c.tf + "s";
			   c.a1 = arg;

			   document.getElementById("a1").beginElement();
			   return parseFloat(arg.dur);
			   }
			   c.start_a2 = function(arg1, arg2) {
			   var t1 = Math.sqrt(Math.pow(arg1.x2 - arg1.x1,2) + Math.pow(arg1.y2 - arg1.y1,2))*c.tf;
			   var t2 = Math.sqrt(Math.pow(arg2.x2 - arg2.x1,2) + Math.pow(arg2.y2 - arg2.y1,2))*c.tf;
			   arg1.dur = t1 + "s", arg2.dur = t2 + "s",
			   c.a2a = arg1, c.a2b = arg2
			   document.getElementById("a2").beginElement();
			   return t1 + t2;
			   }
			   c.goahead = function() {
			   c.running = false;
			   $scope.$apply();
			   if (c.auto == true)
			   window.setTimeout(function(){document.getElementById("button-step").click();}, 2000);
			   
			   }
			   c.modal_open = function() {
			   	c.modal_is_open = "modal_open";
			   }
			   
			   c.modal_close = function() {
			   	c.modal_is_open = "modal_close";
			   	c.prog = JSON.parse(c.progtext);
			   c.reset();
			   }

});
