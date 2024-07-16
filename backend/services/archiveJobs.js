const { execute } = require("../dbConnections/executeQuery");

const getAllTaskDetails = async (job_id) => {
  const getCategories =
    "select * from jobs inner join jobs_categories on jobs.job_id=jobs_categories.job_id where jobs.job_id=?;";
  const categories = await execute(getCategories, [job_id]);
  const categoryImgs = await Promise.all(
    categories.map(async (category) => {
      const imgsQuery =
        "select * from job_category_images where job_category_id=?;";
      const imgs = await execute(imgsQuery, [category.job_category_id]);
      return { ...category, images: imgs };
    })
  );
  console.log(categoryImgs);
  return categoryImgs;
};

const getAllProofDetails = async (job_id) => {
  const workProofsQuery =
    "select work_proof_id,title , work_proofs.description from jobs_categories inner join work_proofs on jobs_categories.job_category_id=work_proofs.job_category_id where jobs_categories.job_id=?;";
  const workProofs = await execute(workProofsQuery, [job_id]);
  const workProofsImg = await Promise.all(
    workProofs.map(async (element) => {
      const imgQuery =
        "select * from work_proof_images where work_proof_id=?; ";
      const imgs = await execute(imgQuery, [element.work_proof_id]);
      return { ...element, images: imgs };
    })
  );
  return workProofsImg;
};
module.exports = { getAllTaskDetails, getAllProofDetails };
