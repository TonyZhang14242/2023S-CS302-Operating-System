#include <defs.h>
#include <riscv.h>
#include <stdio.h>
#include <string.h>
#include <swap.h>
#include <swap_clock.h>
#include <list.h>
#include <pmm.h>


list_entry_t pra_list_head, *curr_ptr;


static int
_clock_init_mm(struct mm_struct *mm)
{     
    //TODO
    mm->sm_priv = NULL; 
    return 0;
}

static int
_clock_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
    //TODO
    list_entry_t *head=(list_entry_t*) mm->sm_priv;
    list_entry_t *entry=&(page->pra_page_link);
    pte_t *ptep = get_pte(mm->pgdir, page->pra_vaddr, 0);
    *ptep = *ptep & PTE_A; // set the access bit of the page table entry
    //If the linked list is empty, make the new page the head
    if (head == NULL){
        list_init(entry);
        mm->sm_priv = entry;
    }
    else{
        // Add the new page to the back of the linked list by adding it before the head (since the list is a reverse list)
        list_add(head -> prev, entry); 
    }

    return 0;
}


static int
_clock_swap_out_victim(struct mm_struct *mm, struct Page ** ptr_page, int in_tick)
{
    //TODO
    list_entry_t *head=(list_entry_t*) mm->sm_priv;
    assert(head != NULL);
    
    curr_ptr= NULL;
    bool found_in_first_round = 0; //flag indicating whether a unaccessed page has been found in first round of iteration
    
    while (curr_ptr!=head) { 
        if (curr_ptr == NULL)
         	curr_ptr = head; //when start, first set pointer to next page of last victim
        struct Page *ptr = le2page(curr_ptr, pra_page_link);
        pte_t *pte = get_pte(mm -> pgdir, ptr -> pra_vaddr, 0);
		bool accessed = *pte & PTE_A; //test whether pte has been accessed
        if (accessed) {//if the page has been accessed, clear the access bit and move on to the next page
             *pte &= ~PTE_A;  //clear the access bit
             curr_ptr = list_next(curr_ptr); 
        } 
        else {//if the page has not been accessed, it is a victim page
            *ptr_page = ptr; // set the victim page
            mm->sm_priv = list_next(curr_ptr); // move the head of the list to the next page
            found_in_first_round =1; //update the flag
            list_del(curr_ptr); // remove the victim page from the list
            return 0;
        }   
    }
    // If a victim page has not been found in the first round, the head of the list is the victim page
    if (found_in_first_round == 0){
        *ptr_page = le2page(head, pra_page_link);
        mm->sm_priv = list_next(head); // set the new position of head page.
        list_del(head);
	}
    return 0;
}





static int
_clock_check_swap(void) {

    cprintf("---------Clock check begin----------\n");
    cprintf("write Virt Page c in clock_check_swap\n");
    *(unsigned char *)0x3000 = 0x0c;
    assert(pgfault_num==4);
    cprintf("write Virt Page a in clock_check_swap\n");
    *(unsigned char *)0x1000 = 0x0a;
    assert(pgfault_num==4);
    cprintf("write Virt Page d in clock_check_swap\n");
    *(unsigned char *)0x4000 = 0x0d;
    assert(pgfault_num==4);
    cprintf("write Virt Page b in clock_check_swap\n");
    *(unsigned char *)0x2000 = 0x0b;  
    assert(pgfault_num==4);
    cprintf("write Virt Page e in clock_check_swap\n");
    *(unsigned char *)0x5000 = 0x0e;
    assert(pgfault_num==5);
    cprintf("write Virt Page b in clock_check_swap\n");
    *(unsigned char *)0x2000 = 0x0b;
    assert(pgfault_num==5);
    cprintf("write Virt Page a in clock_check_swap\n");
    *(unsigned char *)0x1000 = 0x0a;
    assert(pgfault_num==6);
    cprintf("write Virt Page b in clock_check_swap\n");
    *(unsigned char *)0x2000 = 0x0b;
    assert(pgfault_num==6);
    cprintf("write Virt Page c in clock_check_swap\n");
    *(unsigned char *)0x3000 = 0x0c;
    assert(pgfault_num==7);
    cprintf("write Virt Page d in clock_check_swap\n");
    *(unsigned char *)0x4000 = 0x0d;
    assert(pgfault_num==8);
    cprintf("write Virt Page e in clock_check_swap\n");
    *(unsigned char *)0x5000 = 0x0e;
    assert(pgfault_num==9);
    cprintf("write Virt Page a in clock_check_swap\n");
    assert(*(unsigned char *)0x1000 == 0x0a);
    *(unsigned char *)0x1000 = 0x0a;
    assert(pgfault_num==9);
    cprintf("Clock check succeed!\n");

    return 0;
}


static int
_clock_init(void)
{
    return 0;
}

static int
_clock_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}

static int
_clock_tick_event(struct mm_struct *mm)
{ return 0; }


struct swap_manager swap_manager_clock =
{
     .name            = "clock swap manager",
     .init            = &_clock_init,
     .init_mm         = &_clock_init_mm,
     .tick_event      = &_clock_tick_event,
     .map_swappable   = &_clock_map_swappable,
     .set_unswappable = &_clock_set_unswappable,
     .swap_out_victim = &_clock_swap_out_victim,
     .check_swap      = &_clock_check_swap,
};
