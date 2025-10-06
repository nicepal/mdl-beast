<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateCategoryRequest;
use App\Http\Requests\CreateCompanyRequest;
use App\Http\Requests\UpdateCategoryRequest;
use App\Http\Requests\UpdateCompanyRequest;
use App\Models\Category;
use App\Models\Company;
use App\Models\Ticket;
use App\Models\User;
use App\Repositories\CategoryRepository;
use App\Repositories\CompanyRepository;
use Exception;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\Factory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Response;

class CompanyController extends AppBaseController
{
    /** @var CategoryRepository */
    private $categoryRepository;

    public function __construct(CompanyRepository $categoryRepo)
    {
        $this->categoryRepository = $categoryRepo;
    }

    /**
     *  Display a listing of the Category.
     *
     * @param  Request  $request
     * @throws Exception
     *
     * @return Application|Factory|View
     */
    public function index(Request $request)
    {
        return view('companies.index');
    }

    /**
     * Store a newly created Category in storage.
     *
     * @param  CreateCategoryRequest  $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(CreateCompanyRequest $request)
    {
        $input = $request->all();

        $category = $this->categoryRepository->create($input);

        return $this->sendResponse($category, __('messages.success_message.company_save'));
    }

    /**
     * Display the specified Category.
     *
     * @param  Category  $category
     *
     * @return Application|Factory|JsonResponse|View
     */
    public function show(Company $company)
    {
        $users = $assignees = User::whereHas('roles', function (Builder $query) {
            $query->where('id', '!=', getCustomerRoleId());
        })->pluck('name', 'id');

        return view('companies.show', compact('company', 'users', 'assignees'));
    }

    /**
     * Show the form for editing the specified Category.
     *
     * @param Category $category
     *
     * @return Response
     */
    public function edit(Company $company)
    {
        return $this->sendResponse($company, 'Company Retrieved Successfully.');
    }

    /**
     * Update the specified Category in storage.
     *
     * @param Category $category
     * @param UpdateCategoryRequest $request
     *
     * @return Response
     */
    public function update(Company $company, UpdateCompanyRequest $request)
    {
        $input = $request->all();
        $this->categoryRepository->update($input, $company->id);

        return $this->sendSuccess(__('messages.success_message.company_update'));
    }

    /**
     * @param Category $category
     *
     * @return Response
     */
    public function destroy(Company $company)
    {
        $Models = [
            Ticket::class,
        ];
        $result = canDelete($Models, 'category_id', $company->id);
        if ($result) {
            return $this->sendError(__('messages.error_message.company_delete'));
        }
        $company->delete();

        return $this->sendSuccess(__('messages.success_message.company_delete'));
    }

    public function showAllCategories()
    {
        return view('web.company_list');
    }
}
