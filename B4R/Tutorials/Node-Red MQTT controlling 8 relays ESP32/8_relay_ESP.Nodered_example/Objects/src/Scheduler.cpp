
#include "B4RDefines.h"
namespace B4R {
	ScheduledNode::ScheduledNode() {
		eventTime = 0;
		next = NULL;
	}

	void Scheduler::insertBetween(ScheduledNode* n, ScheduledNode* prev, ScheduledNode* next) {
		prev->next = n;
		n->next = next;
	}
	ScheduledNode* Scheduler::getUnused() {
		if (unused == NULL)
			unused = new ScheduledNode();
		ScheduledNode* res = unused;
		unused = unused->next;
		return res;
	}
	Scheduler::Scheduler() {
		first = new ScheduledNode();
		last = new ScheduledNode();
		first->next = last;
		last->next = first;
		unused = NULL;
	}
	void Scheduler::add(ULong x,  FunctionUnion fncu, Byte tag, void* target) {
		ScheduledNode* toAdd = getUnused();
		toAdd->eventTime = x;
		toAdd->functionUnion = fncu;
		toAdd->tag = tag;
		toAdd->target = target;
		if (last->next == first || last->next->eventTime < x) {
			insertBetween(toAdd, last->next, last);
			last->next = toAdd;
		}
		else {
			ScheduledNode* prev = first;
			ScheduledNode* n = first->next;
			while (n->eventTime < x) {
				prev = n;
				n = n->next;
			}
			insertBetween(toAdd, prev, n);
		}
	}
	ScheduledNode* Scheduler::getFirst() {
		ScheduledNode* n = first->next;
		if (n == last)
			return NULL;
		return n;
	}
	void Scheduler::removeFirst() {
		ScheduledNode* n = first->next;
		first->next = n->next;
		if (last->next == n)
			last->next = first;
		n->next = unused;
		unused = n;
	}
	void Scheduler::printList(){
		ScheduledNode* n = first->next;
		while (n != last) {
			::Serial.println(n->eventTime);
			n = n->next;
		}
	}
	void Scheduler::loop() {
		ScheduledNode* first = getFirst();
		if (first != NULL) {
			if (((long)(millis() - first->eventTime)) >= 0) {
				removeFirst();
				if (first->target != NULL)
					first->functionUnion.TimerFunction(first->tag, first->target);
				else
					first->functionUnion.CallSubPlusFunction(first->tag);
			}
		}
		pollers.runAll();
	}
	PollerList::PollerList() {
		first = new PollerNode();
		last = new PollerNode();
		first->next = last;
		last->next = first;
		
	}
	volatile SubVoidVoid PollerList::interruptFnc = NULL;
	void PollerList::setInterrupt(SubVoidVoid fnc) {
		interruptFnc = fnc;
	}
	void PollerList::runAll() {
		
		if (interruptFnc != NULL) { //interrupt
			noInterrupts();
			SubVoidVoid fnc = interruptFnc;
			interruptFnc = NULL;
			interrupts();
			if (fnc != NULL) {
				fnc();
			}
		}
		PollerNode* n = first->next;
		while (n != last) {
			PollerNode* next = n->next; //n->next can be NULL after the function is executed.
			if (n->tag != NULL)
				n->functionUnion.PollerFunction(n->tag);
			else
				n->functionUnion.LooperFunction();
			n = next;
		}
#if defined(ESP_H) && !defined(ESP32)
		wdt_reset();
#endif
	}
	void PollerList::add(FunctionUnion fnc, void* tag) {
		PollerNode* s = new PollerNode();
		s->functionUnion = fnc;
		s->tag = tag;
		add(s);
	}
	void PollerList::add(PollerNode* s) {
		last->next->next = s;
		s->next = last;
		last->next = s;
	}
	void PollerList::remove(PollerNode* pnode) {
		PollerNode* n = first;
		while (n->next != pnode) {
			n = n->next;
			if (n == last)
				return;
		}
		n->next = pnode->next;
		if (last->next == pnode)
			last->next = n;
		pnode->next = NULL;

	}
	Scheduler scheduler;
	PollerList pollers;
	Object be_sender;
	Object* sender = &be_sender;
}
