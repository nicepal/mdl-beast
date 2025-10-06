<?php

namespace App\Http\Livewire;

use App\Models\Category;
use App\Models\Company;
use App\Models\Ticket;
use Exception;
use Illuminate\Database\Eloquent\Builder;
use Livewire\Component;
use Livewire\WithPagination;

class Companies extends Component
{
    use WithPagination;
    protected $paginationTheme = 'bootstrap';

    public $searchByCompany = '';
    protected $listeners = ['deleteCategory'];

    /**
     * @return string
     */
    public function paginationView()
    {
        return 'livewire.custom-pagenation';
    }

//    public function nextPage($lastPage)
//    {
//        if ($this->page < $lastPage) {
//            $this->page = $this->page + 1;
//        }
//    }
//
//    public function previousPage()
//    {
//        if ($this->page > 1) {
//            $this->page = $this->page - 1;
//        }
//    }

    /**
     * @param  Category  $id
     *
     * @throws Exception
     */
    public function deleteCategory($id)
    {
        $Models = [
            Ticket::class,
        ];
        $result = canDelete($Models, 'category_id', $id);
        if ($result) {
            $this->dispatchBrowserEvent('deleted', __('messages.error_message.category_delete'));
        } else {
            $category = Category::find($id);
            $category->delete();
            $this->dispatchBrowserEvent('deleted');
            $this->searchCompany();
        }
    }

    public function updatingsearchByCompany()
    {
        $this->resetPage();
    }

    public function render()
    {
        $companies = $this->searchCompany();

        return view('livewire.companies', compact('companies'))->with('searchByCompany');
    }

    /**
     * @return mixed
     */
    public function searchCompany()
    {
        /** @var Category $query */
        $query = Company::withCount(['ticket', 'openTickets']);

        $query->when($this->searchByCompany != '', function (Builder $query) {
            $query->where(function (Builder $query) {
                $query->orWhere('name', 'like', '%'.strtolower($this->searchByCompany).'%');
                $query->orWhere('color', 'like', '%'.strtolower($this->searchByCompany).'%');
            });
        });
        $query->orderBy('created_at');

        $all = $query->paginate(9);
        $currentPage = $all->currentPage();
        $lastPage = $all->lastPage();
        if ($currentPage > $lastPage) {
            $this->page = $lastPage;
        }

        return $all;
    }
}
